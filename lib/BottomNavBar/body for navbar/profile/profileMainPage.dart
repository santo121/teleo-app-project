import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/fetchingPersonalInfoApi.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/fetchingpersonalInfoModelClass.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/gstpage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/personalInfoRegistretion.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class ProfileMainPage extends StatefulWidget {
  ProfileMainPage({Key key}) : super(key: key);

  @override
  _ProfileMainPageState createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  String shopName;
  FetchingPersonalInfoApiReq request = new FetchingPersonalInfoApiReq();
  String ownerName,
      altphoneNumber,
      email,
      address,
      city,
      state,
      postalcode,
      counttry,
      gstnumber,
      fssai,
      image;
  @override
  void initState() {
    shopName = DataStorage.getstoreName();
    request.vendorId = DataStorage.getVendorId();
    request.vendorToken = DataStorage.getVendorToken();
    ownerName = DataStorage.getownerName();
    altphoneNumber = DataStorage.getaltphonenumber();
    email = DataStorage.getemail();
    address = DataStorage.getaddress();
    city = DataStorage.getcity();
    state = DataStorage.getstate();
    postalcode = DataStorage.getpostalcode();
    counttry = DataStorage.getcountry();
    gstnumber = DataStorage.getgstnumber();
    fssai = DataStorage.getfassai();
    // image = DataStorage.getimageurl() != null ? DataStorage.getimageurl : "";

    super.initState();
  }

// SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder<FetchingpersonalInfoModelClass>(
        future: FetchingPersonalInfoApi().register(
          request,context
        ),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            this.shopName = data.data.storename;
            this.address = data.data.address;
            this.altphoneNumber = data.data.alternatenumber;
            this.city = data.data.city;
            this.counttry = data.data.country;
            this.fssai = data.data.fssai;
            this.gstnumber = data.data.gstnumber;
            this.ownerName = data.data.ownername;
            this.image = data.data.piclocation;
            this.postalcode = data.data.postalcode;
            this.state = data.data.state;
            this.email = data.data.email;
            
            return mainScreen(
                shopNames: shopName,
                address: address,
                city: city,
                fssai: fssai, 
                gst: gstnumber,
                image: image,
                phone: altphoneNumber,
                state: state,
                email: email
                );
          } else {
            return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
          }
        },
      )),
    );
  }

  Widget mainScreen(
          {String phone, shopNames, address, city, state, gst, fssai, image,email}) =>
      Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              padding: EdgeInsets.only(top: 80,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .25,
                        height: MediaQuery.of(context).size.width * .25,
                        child: Center(
                          child: Icon(
                            image != null?null: Icons.business,
                            size: MediaQuery.of(context).size.width * .18,
                            color: Colors.grey,
                          ),
                        ),
                        decoration: BoxDecoration(
                            image: image != null
                                ? DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.fill)
                                : null,
                            shape: BoxShape.circle,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shopNames != null
                                    ? shopNames.toUpperCase()
                                    : "your store",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${email!=null?email:""}",
                                style: TextStyle(fontSize: 12,color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  altphoneNumber != null
                                      ? "Phone:$altphoneNumber"
                                      : "Phone:0000000000",
                                  style: TextStyle(fontSize: 12,color: Colors.white)),
                              SizedBox(height: 5),
                              Text(
                                  address != null
                                      ? "Location:$address/$city/$state"
                                      : "Location:",
                                  style: TextStyle(fontSize: 12,color: Colors.white)),
                              SizedBox(height: 5),
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,top:05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("G.S.T: ${gst!=null?gst:"0000000000"}",style: TextStyle(color: Colors.white,fontSize: 12),),
                        SizedBox(height: 5,),
                        Text("Fssai: ${fssai!=null?fssai:"000000000"}",style: TextStyle(color: Colors.white,fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.library_add_check),
                        title: Text("Licence"),
                        trailing: gstnumber == null
                            ? Icon(
                                Icons.warning,
                                color: Colors.red,
                              )
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditGstNum(
                                    )),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.insert_drive_file_rounded),
                        title: Text("Personal information"),
                        trailing: postalcode == null
                            ? Icon(
                                Icons.warning,
                                color: Colors.red,
                              )
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalInfoRegistretion(
                                    // address: address,
                                    // altphonenumber: altphoneNumber,
                                    // city: city,
                                    // country: counttry,
                                    // email: email,
                                    // fssai:fassai,
                                    // gstnumber: gstnumber,
                                    // // image: image,
                                    // ownername: ownerName,
                                    // postalcode: postalcode,
                                    // state: state,

                                    )),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Log out"),
                        onTap: () {
                          loguout(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   color: Colors.white,
                    //   child: ListTile(
                    //     leading: Icon(Icons.file_copy),
                    //     title: Text("About Us"),
                    //     onTap: () {},
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Future<String> addUnitDialog(BuildContext context, {String gst, fssia}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Licence"),
              content: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "GSTIN:",
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(gst != null ? gst : "000000000000000"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "FSSAI:",
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(fssia != null ? fssia : "100XXXXXXXXXX"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              actions: <Widget>[],
            ));
  }

  Future<String> loguout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Log-Out"),
                ],
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: Text("Log Out")),
                  ],
                ),
              ),
              actions: <Widget>[],
            ));
  }
}

// {
//     "data": [
//         {
//             "id": "ffeb221ded6586d242daf2a3",
//             "ownername": "santo",
//             "storename": "Mu books",
//             "storetype": "Supermarket/General store",
//             "phonenumber": "7902566908",
//             "alternatenumber": "7902566908",
//             "email": "santomartin223@gmail.com",
//             "address": "thrissur",
//             "city": "irinjalkuda",
//             "state": "irinjlakuda",
//             "postalcode": "680121",
//             "country": "india",
//             "gstnumber": "123456789012345",
//             "fssai": ""
//         },
//         {
//             "piclocation": "https://vendorprofileimage.s3.us-east-2.amazonaws.com/ffeb221ded6586d242daf2a3"
//         }
//     ]

// }
