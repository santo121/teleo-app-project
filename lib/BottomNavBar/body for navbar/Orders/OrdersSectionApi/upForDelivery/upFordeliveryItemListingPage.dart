// upFordeliveryItemListingPage

import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/addressApiService.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/addressModelClass.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/upForDeliveryStatusApi.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/upforDeliveryitemsModel.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/upfordeliveryitemsApiService.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/orderedItemListingSection.dart';
import '../../../../../customPageRoute.dart';
import '../../../../../progressHud.dart';
import '../../../../BottomNavBar.dart';

class UpFordeliveryItemListingPage extends StatefulWidget {
  UpFordeliveryItemListingPage(
      {Key key,
      @required this.orderId,
      @required this.name,
      @required this.orderStatus,
      @required this.orderpickup})
      : super(key: key);
  final String orderId, name, orderStatus,orderpickup;

  @override
  _UpFordeliveryItemListingPageState createState() =>
      _UpFordeliveryItemListingPageState();
}

class _UpFordeliveryItemListingPageState
    extends State<UpFordeliveryItemListingPage> {
  bool proceed = false;
  UpForDeliveryStatusapirequest requestStatus = UpForDeliveryStatusapirequest();
  UpfordeliveryitemsApiServicerequest request = new UpfordeliveryitemsApiServicerequest();
  // OrderAcceptingrequest ordrequest = new OrderAcceptingrequest();
  @override
  void initState() {
    super.initState();
    request.id = DataStorage.getVendorId();
    request.vtoken = DataStorage.getVendorToken();
    request.orderId = widget.orderId;
    requestStatus.id=DataStorage.getVendorId();
    requestStatus.vtoken =DataStorage.getVendorToken();
    requestStatus.orderid=widget.orderId;
    
    // ordrequest.id = DataStorage.getVendorId();
    // ordrequest.vtoken = DataStorage.getVendorToken();
    // ordrequest.orderId = widget.orderId;
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
          FutureBuilder<UpforDeliveryitemsModel>(
            future: UpfordeliveryitemsApiService().getUpForDeliveryItem(request, context),
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
          proceedingSection() 
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
            // Container(
            //   child:Padding(
            //     padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
            //     child: Row(
            //       children: [
            //         Text("Data : ",style: TextStyle(fontSize: 16),)
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              //time section
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Order Time : ",
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //     Text(
                    //       time,
                    //       style: TextStyle(fontSize: 16,color: Colors.green),
                    //     ),
                    //   ],
                    // ),
                    ElevatedButton(
                        onPressed: () {
                          addUnitDialog(context);
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Row(
                          children: [
                            Icon(Icons.location_history),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Address"),
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
            ),
            
            Container(
              height: MediaQuery.of(context).size.width * .4,
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
                margin: EdgeInsets.only(top: 20,bottom: 10),
                child: Text("Proceed with the Orders")),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                            isApiCallProcess = true;
                          });
                        requestStatus.status = "Reverted";
              UpForDeliveryStatusapi services = UpForDeliveryStatusapi();
              print(requestStatus.toJson());
              print(requestStatus.toHead());

              services.deliveryStatus(requestStatus, context).then((value) => {
                    if (value.msg != null)
                      {
                        setState(() {
                          isApiCallProcess = false;
                        }),
                       Navigator.push(
                          context,
                          CustomPageRoute(child: BottomNavBar(sections: 0,),direction: AxisDirection.left)
                        ),
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text(value.msg),
                        //   ))
                      }
                    else
                      {
                        setState(() {
                          isApiCallProcess = false;
                        }),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value.error),
                          ))
                      }
                  });
                        
                      },
                      style: ElevatedButton.styleFrom(primary:Colors.black),
                      child: Row(
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Cancel Order"),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                               setState(() {
                isApiCallProcess = true;
              });
              if (widget.orderpickup.toString() == "Home Delivery") {
                requestStatus.status = "Delivered";
                UpForDeliveryStatusapi services = UpForDeliveryStatusapi();
                services.deliveryStatus(requestStatus, context).then((value) => {
                      if (value.msg != null)
                        {
                          setState(() {
                            isApiCallProcess = false;
                          }),
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text(value.msg),
                          // )),
                          Navigator.push(
                          context,
                          CustomPageRoute(child: BottomNavBar(sections: 0,),direction: AxisDirection.left)
                        ),
                        }
                      else
                        {
                          setState(() {
                            isApiCallProcess = false;
                          }),
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value.error),
                          )),
                        }
                    });
              } else if (widget.orderpickup.toString() == "Store Pickup") {
                requestStatus.status = "Delivered";
                UpForDeliveryStatusapi service = UpForDeliveryStatusapi();
                service.deliveryStatus(requestStatus, context).then((value) => {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text(value.msg),
                      // )),
                      if (value.msg != null)
                        {
                          setState(() {
                            isApiCallProcess = false;
                          }),
                          Navigator.push(
                          context,
                          CustomPageRoute(child: BottomNavBar(sections: 0,),direction: AxisDirection.left)
                        ),
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text(value.msg),
                          // ))
                        }
                      else
                        {
                          setState(() {
                            isApiCallProcess = false;
                          }),
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value.error),
                          ))
                        }
                    });
              }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 5,),
                          Text(widget.orderpickup=="Store Pickup"?"Delivered":"Up for delivery"),
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
  Future<String> addUnitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Address"),
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
                  child:AddressSection(orderId: widget.orderId,)),
              actions: <Widget>[],
            ));
  }
}

class AddressSection extends StatefulWidget {
  AddressSection({Key key,@required this.orderId}) : super(key: key);
  final String orderId;
  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
AddressApiServiceRequest request = new AddressApiServiceRequest();
@override
void initState() { 
  super.initState();
  request.vtoken=DataStorage.getVendorToken();
  request.id = DataStorage.getVendorId();
  request.orderId = widget.orderId;
}

  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.height/3,
       child:
      //  mainSection(),
       
       FutureBuilder<AddressModelClass>(
            future: AddressApiService().getAddress(request, context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data.details;
                return mainSection(
                  address: data.address,
                  housenum: data.houseno
                );
              } else {
                return Center(
                    child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ));
              }
            },
          ),
    );
  }
  Widget mainSection(
{String address,String housenum}
  )=>
  Column(
      children: [
        Row(
          children: [
            Text("Address : "),
            Text(address),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text("House no : "),
            Text(housenum),
          ],
        ),
        
      ],
       );
}