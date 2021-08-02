import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/forDelivery.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/history.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/recivedPage.dart';

import 'package:mallu_vendor/dataStorage.dart';

import 'homePageApi/homePageStoreStatusApiService.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageStoreStatusApiServiceRequest reqStatus =
      new HomePageStoreStatusApiServiceRequest();
  String shopName = "";
  bool shope;
  bool shopstatus;
  @override
  void initState() {
    super.initState();
    shopName =
        DataStorage.getstoreName() != null ? DataStorage.getstoreName() : null;
    shopstatus = DataStorage.getShopStatus() != null
        ? DataStorage.getShopStatus()
        : true;
    reqStatus.id = DataStorage.getVendorId();
    reqStatus.vtoken = DataStorage.getVendorToken();
  }

  bool received = true, delivery = false, waiting = false;

  @override
  Widget build(BuildContext context) {
    return shopstatus
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: Container(),
                title: Text(
                    shopName != null ? "${shopName.toUpperCase()}" : "Orders"),
                actions: [
                  stockvalue(),
                  Center(
                    child: Container(
                      child: Text(
                        shopstatus ? "O p e n" : "C l o s e",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: shopstatus ? Colors.green : Colors.red),
                      ),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          // boxShadow: [BoxShadow(color: Colors.black,offset: Offset(0,3),blurRadius: 4,spreadRadius: .3)],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(
                        text: "Received",
                        icon: Icon(
                          Icons.call_received,
                        )),
                    Tab(
                      text: "Up For Delivery",
                      icon: Icon(Icons.delivery_dining),
                    ),
                  ],
                ),
              ),
              body: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  TabBarView(children: [
                    Center(child: RecivedPage()),
                    Center(child: UpForDelivery()),
                  ]),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryPage()),
                          );
                        },
                        child: Text(
                          "History",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, shape: StadiumBorder()),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          share(title: DataStorage.getstoreName());
                        },
                        child: Text(
                          "share Store",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, shape: StadiumBorder()),
                      ),
                    ),
                  )
                  
                  ),
                ],
              ),
            ),
          )
        : StoreClosed();
  }

  Widget mainHeading() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .06,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      );

  Widget topNavBar() => Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  this.received = true;
                  this.delivery = false;
                  this.waiting = false;
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .06,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                        child: Text(
                      "Received",
                      style: TextStyle(
                          color: Colors.white, fontSize: received ? 18 : 14),
                    )),
                  ),
                  received
                      ? Container(
                          width: MediaQuery.of(context).size.width * .025,
                          height: MediaQuery.of(context).size.width * .025,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        )
                      : SizedBox()
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: 1,
              height: MediaQuery.of(context).size.height * .04,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  this.received = false;
                  this.delivery = true;
                  this.waiting = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .06,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      height: MediaQuery.of(context).size.height * .06,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                          child: Text("Up For Delivery",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: delivery ? 18 : 14))),
                    ),
                    delivery
                        ? Container(
                            width: MediaQuery.of(context).size.width * .025,
                            height: MediaQuery.of(context).size.width * .025,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: 1,
              height: MediaQuery.of(context).size.height * .04,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  this.received = false;
                  this.delivery = false;
                  this.waiting = true;
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .06,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                        child: Text("Waiting",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: waiting ? 18 : 14))),
                  ),
                  waiting
                      ? Container(
                          width: MediaQuery.of(context).size.width * .025,
                          height: MediaQuery.of(context).size.width * .025,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        )
                      : SizedBox()
                ],
              ),
            )
          ],
        ),
      );


Future<void> share({String title}) async {
        String vendorid = DataStorage.getVendorId();
    await FlutterShare.share(
        title: "Mallu vendor",
        text: title,
        linkUrl: "https://teleo-online.com/home/$vendorid",
        chooserTitle: 'Where you want to share ?');
  }


  Widget stockvalue() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            activeColor: Colors.white,
            value: shopstatus,
            onChanged: (val) async {
              setState(() {
                this.shope = val;
                reqStatus.status = val.toString();
              });

              print(reqStatus.toJson());
              print(reqStatus.toHeader());
              HomePageStoreStatusApiService service =
                  HomePageStoreStatusApiService();
              service.storeStatusService(reqStatus, context).then((value) => {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content:
                    //       Text(shope ? "store is opened" : "Store is closed"),
                    // ))
                  });

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavBar(
                          sections: 0,
                        )),
              );

              await DataStorage.setshopStatus(shopStatus: val);
            }),
      );
}

class StoreClosed extends StatefulWidget {
  StoreClosed({Key key}) : super(key: key);

  @override
  _StoreClosedState createState() => _StoreClosedState();
}

class _StoreClosedState extends State<StoreClosed> {
  HomePageStoreStatusApiServiceRequest reqStatus =
      new HomePageStoreStatusApiServiceRequest();
  @override
  void initState() {
    super.initState();
    reqStatus.id = DataStorage.getVendorId();
    reqStatus.vtoken = DataStorage.getVendorToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      //   leading: SizedBox(),
      //   title: Text("Shop is Closed"),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your store is closed ! \n press the button to open",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  reqStatus.status = true.toString();
                });

                HomePageStoreStatusApiService service =
                    HomePageStoreStatusApiService();
                service.storeStatusService(reqStatus, context).then((value) => {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("store is opened"),
                      // ))
                    });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                            sections: 0,
                          )),
                );
                await DataStorage.setshopStatus(shopStatus: true);
              },
              child: Text("Open Store"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
