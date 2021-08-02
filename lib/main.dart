import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/ModelClassesAndServices/otpValidation.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/ModelClassesAndServices/phoneNumValidation.dart';
import 'package:mallu_vendor/Manager%20Or%20Owner%20Sction/regAsManagerOrOwner.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/Widgets/Map/applicationBlock.dart';
import 'package:mallu_vendor/Widgets/Map/latlongProvider.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:mallu_vendor/progressHud.dart';
import 'package:mallu_vendor/vTokenProvider.dart';
import 'package:provider/provider.dart';
import 'BottomNavBar/body for navbar/Products/productNameAndCategoryType.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Map<int, Color> color = {
  //   50: Color.fromRGBO(136, 14, 79, .1),
  //   100: Color.fromRGBO(136, 14, 79, .2),
  //   200: Color.fromRGBO(136, 14, 79, .3),
  //   300: Color.fromRGBO(136, 14, 79, .4),
  //   400: Color.fromRGBO(136, 14, 79, .5),
  //   500: Color.fromRGBO(136, 14, 79, .6),
  //   600: Color.fromRGBO(136, 14, 79, .7),
  //   700: Color.fromRGBO(136, 14, 79, .8),
  //   800: Color.fromRGBO(136, 14, 79, .9),
  //   900: Color.fromRGBO(136, 14, 79, 1),
  // };

  @override
  Widget build(BuildContext context) {
    String vendorId = DataStorage.getVendorId() ?? null;
    String vendortoken = DataStorage.getVendorToken() ?? null;
    String storeNameFinish = DataStorage.getstoreName() ?? null;
    print(vendorId);
    print(vendortoken);

    // MaterialColor primary = MaterialColor(0xFF2600FF, color);
    // final tokens = Provider.of<VTokenProvider>(context);
    // tokens.changeVendorId(vendorId);
    // tokens.changeVendorToken(vendorToken);
    // print(tokens.vendorId);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MapDataProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApplicationBlock(),
          ),
          ChangeNotifierProvider(
            create: (context) => StoreNameAndTypeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductNameAndCategoryTypeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LatlongProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => VTokenProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: storeNameFinish != null
              ? BottomNavBar(sections: 0,)
              : vendorId != null
                  ? RegAsManagerOrOwner()
                  : MyHomePage(title: 'Flutter Demo Home Page'),
          // home: LoadingPage(),
          // home: BottomNavBar(),
          //  home: HomePage(),
          // vendorId!=null?BottomNavBar():
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    keyboardEnabel = true;
    super.initState();
  }

  bool pressedVerify = false;
  PhoneNumRequestModel requestModel = new PhoneNumRequestModel();
  OtpRequest otpRequest = new OtpRequest();
  Color selectionColor = Color(0xFF55B2D5);
  String phoneNumber;
  String vendorToken;
  String token;
  String vendorIdFromOtp;
  bool isApiCallProcess = false;
  bool verifyotp = false;
  bool resendOtpButton = false;
  bool keyboardEnabel = false;

  @override
  void dispose() {
    keyboardEnabel = true;
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    double logButton = MediaQuery.of(context).size.width - 100;
    final mapDataProvider = Provider.of<MapDataProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Image(image: AssetImage('assets/VENDORATZ.png')),
                  Container(
                    // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ],
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                // RegistrationSection(),
                                // detailingSection(),
                                pressedVerify == true
                                    ? otpVerificationScreen()
                                    : detailingSection(),
                                SizedBox(
                                  height: 45,
                                ),
                                pressedVerify == true
                                    ? otpVerification(logButton)
                                    : phoneNumberSection(logButton),

                                SizedBox(
                                  height: 45,
                                ),
                                pressedVerify == true
                                    ? verificationButton(
                                        logButton, mapDataProvider)
                                    : otpVerificationButton(
                                        logButton, phoneNumber),
                                SizedBox(
                                  height: 45,
                                ),
                                pressedVerify
                                    ? TextButton(
                                        onPressed:
                                            resendOtpButton ? () {} : null,
                                        child: Text("Resend Otp"))
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget verificationButton(logButton, mapDataProvider) => SizedBox(
      width: logButton,
      height: 56,
      child: ElevatedButton(
        onPressed:
            //  resendOtpButton
            //     ? null
            //     :
            () async {
          if (_formKey.currentState.validate()) {
            isApiCallProcess = true;
            this.otpRequest.vToken =
                this.vendorToken; //hear we give VendorToken to header
            print(otpRequest.toJson());
            print(otpRequest.toHeader());
            OtpServices services = new OtpServices();
            services.login(otpRequest, context).then((value) => {
                  if (value.id != null)
                    {
                      setState(() async {
                        this.vendorIdFromOtp = value.id;
                        isApiCallProcess = false;
                        value.store != "Null"
                            ? mapDataProvider.changefinshingButton(true)
                            : mapDataProvider.changefinshingButton(false);

                        value.store != "Null"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                      sections: 0,
                                          vendorId: vendorIdFromOtp,
                                          vendorToken: vendorToken,
                                        )),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegAsManagerOrOwner(
                                          vendorIdFromOtp: vendorIdFromOtp,
                                          vendorToken: vendorToken,
                                        )),
                              );
                        // :
                        //;
                        await DataStorage.setVendorId(
                            vendorId: vendorIdFromOtp);
                        await DataStorage.setVendorToken(
                            vendorToken: vendorToken);
                        await DataStorage.setfirstProduct(
                            value: value.storename != "Null" ? true : false);
                        await DataStorage.setstoreName(
                            value: value.store != "Null" ? value.store : "");
                      }),
                    }
                  else if (value.error != null)
                    {
                      setState(() {
                        isApiCallProcess = false;
                      }),
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.error)))
                    }
                  else
                    {
                      setState(() {
                        isApiCallProcess = false;
                      }),
                      // ScaffoldMessenger.of(context)       
                      //     .showSnackBar(SnackBar(content: Text(value.msg)))
                    }
                });
            setState(() {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => RegAsManagerOrOwner()),
              // );
            });
          }
        },
        child: Text(
          "Verify OTP",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
      ));
  Widget otpVerificationButton(logButton, phoneNumber) => SizedBox(
      width: logButton,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print(phoneNumber);
            setState(() {
              isApiCallProcess = true;
            });
            PhoneNumValidation sevices = new PhoneNumValidation();
            sevices.login(requestModel, context).then((value) => {
                  if (value.vToken != null)
                    {
                      setState(() {
                        this.token = value.token;
                      }),
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text(value.msg))),
                      setState(() {
                        this.isApiCallProcess = false;
                        this.pressedVerify = true;
                        print(value.vToken);
                        this.vendorToken = value.vToken;
                      }),
                    }
                  else if (value.error != null)
                    {
                      setState(() {
                        this.isApiCallProcess = false;
                      }),
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.error)))
                    }
                  else
                    {
                      setState(() {
                        this.isApiCallProcess = false;
                      }),
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text(value.msg)))
                    }
                });

            print(requestModel.toJson());
          }
        },
        child: Text(
          "Verify with OTP",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
      ));

  Widget detailingSection() => Container(
        child: Column(
          children: [
            ListTile(),
            Center(
              child: Column(
                children: [
                  Text(
                    "Add phone number",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[400]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Launch your own online store ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  Widget phoneNumberSection(logButton) => Container(
      width: logButton,
      child: TextFormField(
        validator: (val) {
          if (val.length != 10) {
            return "enter proper phone number";
          } else {
            return null;
          }
        },
        key: Key("1"),
        keyboardType: TextInputType.phone,
        onTap: () {
          this.keyboardEnabel = false;
        },
        decoration: InputDecoration(
          labelText: "Enter phone number",
          hintText: "000 0000 000",
          prefixText: "+91 ",
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: (val) {
          this.phoneNumber = val;
          print(phoneNumber.length);
          this.requestModel.phoneNumber = val;
        },
      ));

  Widget otpVerificationScreen() => Container(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      pressedVerify = false;
                    });
                  }),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "O T P",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[400]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Just a single step to lounch your store $token",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  buildTimer(begin: 59.0, seconds: 59)
                ],
              ),
            )
          ],
        ),
      );
  Widget otpVerification(logButton) => Container(
      width: logButton,
      child: TextFormField(
        onTap: () {
          setState(() {
            this.keyboardEnabel = false;
          });
        },
        readOnly: keyboardEnabel,
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 6) {
            return "please enter proper Otp";
          }
          return null;
        },
        key: Key("2"),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "Enter Otp",
          hintText: "0 0 0 0 0 0",
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: (val) {
          this.otpRequest.token = val;
        },
      ));

  Row buildTimer({double begin, int seconds}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: begin, end: 0.0),
          duration: Duration(seconds: seconds),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.blue),
          ),
          onEnd: () {
            print("time out");
            setState(() {
              resendOtpButton = true;
            });
          },
        )
      ],
    );
  }

  
}
