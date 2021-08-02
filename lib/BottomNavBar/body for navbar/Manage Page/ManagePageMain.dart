import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Manage%20Page/My%20Customers/myCustomers.dart';
import 'package:provider/provider.dart';

import '../../../vTokenProvider.dart';
import 'Delivery Service/DeliveryService.dart';

class ManagePageMain extends StatefulWidget {
  ManagePageMain({Key key}) : super(key: key);

  @override
  _ManagePageMainState createState() => _ManagePageMainState();
}

class _ManagePageMainState extends State<ManagePageMain> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        title: Text("Manage Shop"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCustomers()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.green,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("My\nCustomers"),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        notAvail(context, "Online Payment");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.indigo,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Online\nPayment"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        notAvail(context, "Discount Coupons");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.yellow,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Discount\nCoupons"),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        notAvail(context, "Marketing Design");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.purple,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Marketing\nDesign"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        notAvail(context, "Store QR Code");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.red,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Store\nQR Code"),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        notAvail(context, "Extra Charges");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.black,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Extra\nCharges"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeliveryServicePage()),
                        );

                        // addUnitDialog(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: .5)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                                color: Colors.purpleAccent,
                                child: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Delivery\nService"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> addUnitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Delivery Service"),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              content: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: DeliveryServices()),
              actions: <Widget>[],
            ));
  }

  Future<String> notAvail(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(text),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  children: [Text("$text service is not available now")],
                ),
              ),
              actions: <Widget>[],
            ));
  }
}

class DeliveryServices extends StatefulWidget {
  DeliveryServices({Key key}) : super(key: key);

  @override
  _DeliveryServicesState createState() => _DeliveryServicesState();
}

class _DeliveryServicesState extends State<DeliveryServices> {
  bool valueOne = false, valuetwo = false;
  @override
  Widget build(BuildContext context) {
    final switches = Provider.of<VTokenProvider>(context);
    valueOne = switches.deliverySwitchOne.value != null
        ? switches.deliverySwitchOne.value
        : false;
    valuetwo = switches.deliverySwitchTwo.value != null
        ? switches.deliverySwitchTwo.value
        : false;
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Pick from store",
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text("Enable it to pick from store"),
            trailing: switchesone(switches),
            // trailing: ,
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Home delivery",
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text("Enable it for Home Delivery"),
            trailing: switchestwo(switches),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget switchesone(switches) => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            value: valueOne,
            onChanged: (val) {
              setState(() {
                this.valueOne = val;
                switches.changeDeliverySwitchOne(val);
              });
            }),
      );
  Widget switchestwo(switches) => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            value: valuetwo,
            onChanged: (val) {
              setState(() {
                this.valuetwo = val;
                switches.changeDeliverySwitchTwo(val);
              });
            }),
      );
}
