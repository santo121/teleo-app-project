import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/Ordered%20Items%20api%20section/orderdItemListingModelClass.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/Ordered%20Items%20api%20section/orderedItemListingApiService.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/orderedItemListingSection.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/home%20page/constSizes.dart';

import '../../../customPageRoute.dart';
import '../../../progressHud.dart';
import 'OrdersSectionApi/orderAcceptingApi.dart';

class RecievedDetailsPage extends StatefulWidget {
  RecievedDetailsPage(
      {Key key,
      @required this.orderId,
      @required this.name,
      @required this.orderStatus})
      : super(key: key);
  final String orderId, name, orderStatus;

  @override
  _RecievedDetailsPageState createState() => _RecievedDetailsPageState();
}

class _RecievedDetailsPageState extends State<RecievedDetailsPage> {
  bool proceed = false;
  OrderdItemListingrequest request = new OrderdItemListingrequest();
  OrderAcceptingrequest ordrequest = new OrderAcceptingrequest();
  @override
  void initState() {
    super.initState();
    request.id = DataStorage.getVendorId();
    request.vtoken = DataStorage.getVendorToken();
    request.orderId = widget.orderId;
    ordrequest.id = DataStorage.getVendorId();
    ordrequest.vtoken = DataStorage.getVendorToken();
    ordrequest.orderId = widget.orderId;
  }

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order: ${widget.orderId}"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<OrderdItemListingModelClass>(
            future: OrderdItemListingService().getOrderedItem(request, context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                String date = data.orderedtime;
                String name = data.username;
                String total = data.sum.toString();
                String status = data.status;
                String paymentmethod = data.paymentmethod;
                String phone = data.phonenumber;
                String deliveryMethod = data.delivery;
                final map = data.data;
                
                return mainPage(map,
                    name: name,
                    time: date,
                    totalPrice: total,
                    status: status,
                    payment: paymentmethod,
                    phonenumber: phone,
                    deliveryMethod: deliveryMethod);
              } else {
                return Center(
                    child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ));
              }
            },
          ),
          widget.orderStatus == "pending" ? proceedingSection() : Container(),
        ],
      ),
    );
  }

  Widget mainPage(List data,
          {@required String name,
          totalPrice,
          phonenumber,
          time,
          status,
          deliveryMethod,
          payment}) =>
      Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              //time section
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   "Ordered Time: $time",
                    //   style: TextStyle(fontSize: 16),
                    // ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: status.toString() != "accepted"
                                ? Colors.yellow[800]
                                : Colors.green),
                        child: Row(
                          children: [
                            Icon(Icons.donut_small),
                            SizedBox(
                              width: 10,
                            ),
                            Text(status),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                customLaunch('tel:+91 $phonenumber');
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  Text("+91 $phonenumber"),
                                ],
                              ))
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .35,
                      color: Colors.grey[300],
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final userdata = data[index];
                //             map[index].username,
                // map[index].imagelocation,
                // map[index].orderid,
                // map[index].orderstatus,
                // map[index].price,
                // map[index].productname,
                // map[index].quantity,
                // map[index].total,
                // map[index].unit,
                // map[index].userid,
                // map[index].username,

                            return OrderedItemListingSection(
                              // deliveryType: userdata.orderpickup.toString(),
                              orderstatus: userdata.orderstatus.toString(),
                              // ordertime: userdata.ordertime.toString(),
                              // paymentType: userdata.paymentmode.toString(),
                              price: userdata.price.toString(),
                              productName: userdata.productname,
                              quntity: userdata.quantity.toString(),
                              unit: userdata.unit,
                              userid: userdata.userid,
                              image: userdata.imagelocation,
                            );
                          })
                      // children: [
                      //   // OrderedItemListingSection(),
                      //   // OrderedItemListingSection(),
                      //   // OrderedItemListingSection(),
                      //   // OrderedItemListingSection(),
                      // ],
                      // String productname,
                      // String quantity,
                      // String price,
                      // String unit,
                      // String ordertime,
                      // String orderstatus,
                      // String userid,
                      // String orderpickup,
                      // String paymentmode,
                      ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("item total:"),
                              Text("₹ $totalPrice"),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery fee:"),
                              Text("₹ 0"),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Grand total:"),
                              Text("₹ $totalPrice"),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        // proceed ? payment() : proceedingSection(),
                        payments(deliveryMethod, payment),

                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget payments(deliveryMethod, payment) => Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "DeliveryMethod",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("${deliveryMethod.toString().toUpperCase()}"))
                ],
              ),
            ),
            Container(
                child: Column(
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text("${payment.toString().toUpperCase()}"))
              ],
            )),
          ],
        ),
      );
  Widget proceedingSection() => Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.width * .29,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  spreadRadius: .8,
                  blurRadius: 6,
                  color: Colors.grey)
            ]),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Text("Proceed with the Orders")),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ordrequest.status = "Declined";
                        });
                        OrderAcceptingApi service = new OrderAcceptingApi();
                        service
                            .orderStatus(ordrequest, context)
                            .then((value) => {
                                  if (value.msg != null)
                                    {
                                      Navigator.push(
                          context,
                          CustomPageRoute(child: BottomNavBar(sections: 0,),direction: AxisDirection.left)
                        ),
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(value.error),
                                      ))
                                    }
                                });
                      },
                      style: ElevatedButton.styleFrom(primary: black),
                      child: Row(
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Reject"),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        setState(() {
                          this.isApiCallProcess = true;
                        });
                        setState(() {
                          ordrequest.status = "Accepted";
                        });
                        OrderAcceptingApi service = new OrderAcceptingApi();
                        service
                            .orderStatus(ordrequest, context)
                            .then((value) => {
                                  if (value.msg != null)
                                    {
                                      setState(() {
                                        this.isApiCallProcess = false;
                                      }),
                                      Navigator.push(
                          context,
                          CustomPageRoute(child: BottomNavBar(sections: 0,),direction: AxisDirection.left)
                        ),
                                    }
                                  else
                                    {
                                      setState(() {
                                        this.isApiCallProcess = false;
                                      }),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(value.error),
                                      ))
                                    }
                                });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          Text("Proceed"),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      );
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    } 
  }
}
