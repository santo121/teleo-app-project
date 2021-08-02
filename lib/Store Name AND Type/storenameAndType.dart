import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/otherSectionCategoryAndSubCategory.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/Store%20name%20and%20type%20services/getShoptypejson.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/Store%20name%20and%20type%20services/poststorenameAndType.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNamePanelWidget.dart';
import 'package:mallu_vendor/progressHud.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../dataStorage.dart';

class StoreNameAndType extends StatefulWidget {
  final String vendorToken;
  final String vendorIdFromOtp;
  StoreNameAndType({this.vendorToken, this.vendorIdFromOtp});
  @override
  _StoreNameAndTypeState createState() => _StoreNameAndTypeState();
}

class _StoreNameAndTypeState extends State<StoreNameAndType> {
  final myController = TextEditingController();
  GetShopTypeRequest request = GetShopTypeRequest();
  String vendorToken, vendorId;
  @override
  void initState() {
    myController.addListener(_printLatestValue);
    // this.vendorToken=widget.vendorToken;
    // this.vendorId=widget.vendorIdFromOtp;
    vendorId = DataStorage.getVendorId() ?? null;
    vendorToken = DataStorage.getVendorToken() ?? null;
    request.vToken = vendorToken;
    request.id = vendorId;
    print(vendorId);
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    buttonKeyBord = true;
    super.dispose();
  }

  void _printLatestValue() {
    // print('Second text field: ${myController.text}');
  }
  final panelController = PanelController();
  static const double fabHeightClosed = 10;
  double fabHeight = fabHeightClosed;
  bool buttonKeyBord = true;
  String shopType = "";
  String shopName = "";
  String chooseCategoryData = "";
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    final dataProvider = Provider.of<StoreNameAndTypeProvider>(context);
    setState(() {
      buttonKeyBord = dataProvider.storeTypeOtherButton.value != null
          ? dataProvider.storeTypeOtherButton.value
          : true;
      shopType = dataProvider.storeTypeselection.value != null
          ? dataProvider.storeTypeselection.value
          : null;
      if (buttonKeyBord == true) {
        setState(() {
          myController.clear();
          shopType = dataProvider.storeTypeselection.value;
        });
      } else if (buttonKeyBord == false) {
        final type = myController.text;
        setState(() {
          shopType = type;
        });
      }
    });
    
// OtherSectionCategoryAndSubCategory

    final panelHeightOpen = MediaQuery.of(context).size.height * .4;
    final panelHeightclose = MediaQuery.of(context).size.height * .001;
    return 
     Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SlidingUpPanel(
          body: mainSectionofthisScreen(dataProvider),
          panelBuilder: (controller) => StorNameFetchedData(
            vendorId: widget.vendorIdFromOtp,
            vendorToken: widget.vendorToken,
            controller: controller,
            panelController: panelController,
          ),
          controller: panelController,
          minHeight: panelHeightclose,
          maxHeight: panelHeightOpen,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          parallaxEnabled: true,
          parallaxOffset: .05,
          onPanelSlide: (value) => setState(() {
            final panelMaxScroll = panelHeightOpen - panelHeightclose;
            fabHeight = value * panelMaxScroll;
          }),
        ),
        Positioned(
            bottom: fabHeight,
            right: 0,
            left: 0,
            child: Container(
                width: MediaQuery.of(context).size.height,
                child: Center(child: buttonForContinue(context))))
      ],
    ));
  }

  Widget mainSectionofthisScreen(dataProvider) => Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [backgroudSection(context, dataProvider)],
          ),
        ],
      ));

  Widget backgroudSection(context, dataProvider) => Container(
        margin: EdgeInsets.only(top: 100),
        width: MediaQuery.of(context).size.width * .95,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val.length < 3) {
                    return "enter shop name";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    this.shopName = val;
                  });
                },
                onTap: closeAutomaticButtonTaped,
                key: Key("1"),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter shop name",
                  hintText: "Shop Name",
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onTap: () {
                  if (panelController.isPanelOpen) {
                    panelController.close();
                    setState(() {
                      buttonKeyBord = true;
                      dataProvider.changeStoreTypeOtherButton(true);
                    });
                  } else {
                    panelController.open();
                    setState(() {
                      buttonKeyBord = true;
                      dataProvider.changeStoreTypeOtherButton(true);
                    });
                  }
                },
                onChanged: (val) {
                  setState(() {
                    chooseCategoryData = val;
                  });
                },
                controller: myController,
                readOnly: buttonKeyBord,
                key: Key("2"),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Shop Type",
                  counterText: buttonKeyBord != false
                      ? "Tap to get Key board"
                      : "Tap to get suggestion",
                  hintText: shopType != null ? shopType : "Shop type",
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
  Widget buttonForContinue(context) => Container(
      width: MediaQuery.of(context).size.width * .95,
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              setState(() {
                isApiCallProcess = true;
              });
              ShopNameAndStorePostRequest request =
                  ShopNameAndStorePostRequest();
              request.storename = this.shopName;
              request.storeType =
                  this.shopType != null ? this.shopType : "others";
              request.id = this.vendorId;
              request.vtoken = this.vendorToken;
              ShopNameAndStorePostService service =
                  ShopNameAndStorePostService();
              service.postStorename(request, context).then((value) => {
                    if (value.msg != null)
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value.msg))),
                        print(
                            "2121212121212121212121212121212121  ${value.msg}"),
                        setState(() async {
                          isApiCallProcess = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar(
                                  sections: 0,
                                      vendorId: this.vendorId,
                                      vendorToken: this.vendorToken,
                                    )),
                          );
                          await DataStorage.setstoreName(value: this.shopName);
                        }),
                      }
                    else
                      {
                        setState(() {
                          isApiCallProcess = false;
                        }),
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value.error))),
                      }
                  });

              // print("jdsgfkdsfkdsfkjdsfkjdsfkdsj ${myController.text}");
            }
          },
          child: Text("C O N T I N U E")));
  void automaticButtonTaped() => buttonKeyBord
      ? setState(() {
          panelController.isPanelOpen
              ? panelController.close()
              : panelController.open();
        })
      : setState(() {
          panelController.isPanelOpen
              ? panelController.close()
              : panelController.open();
        });
  void closeAutomaticButtonTaped() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.close();
}
