import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/upForDeliveryStatusApi.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/upFordeliveryItemListingPage.dart';

import 'package:mallu_vendor/dataStorage.dart';

import '../../../../customPageRoute.dart';
import '../../../../progressHud.dart';

class UpForDeliverySectionOrderWidget extends StatefulWidget {
  UpForDeliverySectionOrderWidget(
      {Key key,
      @required this.orderstatus,
      @required this.price,
      @required this.count,
      @required this.name,
      @required this.orderid,
      @required this.orderpickup})
      : super(key: key);
  final String count, price, orderstatus, orderid, name, orderpickup;
  @override
  _UpForDeliverySectionOrderWidgetState createState() =>
      _UpForDeliverySectionOrderWidgetState();
}

class _UpForDeliverySectionOrderWidgetState
    extends State<UpForDeliverySectionOrderWidget> {
  UpForDeliveryStatusapirequest request = UpForDeliveryStatusapirequest();
  @override
  void initState() {
    super.initState();
    request.id = DataStorage.getVendorId();
    request.vtoken = DataStorage.getVendorToken();
    request.orderid = widget.orderid;
  }

  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpFordeliveryItemListingPage(
                    orderId: widget.orderid,
                    name: widget.name,
                    orderStatus: widget.orderstatus,
                    orderpickup: widget.orderpickup,
                  )),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  detailsSection(),
                ],
              ),
            ),
          ),
          Positioned(right: 0, top: 0, child: cancelButton()),
          notificationButon(),
        ],
      ),
    );
  }

  Widget detailsSection() => GestureDetector(
        onTap: () {},
        child: Container(
          child: Row(
            children: [
              // Container(
              //   width: MediaQuery.of(context).size.width * .2,
              //   height: MediaQuery.of(context).size.width * .2,
              //   decoration: BoxDecoration(
              //     // border: Border.all(),
              //     borderRadius: BorderRadius.circular(5),
              //   boxShadow: [
              //         BoxShadow(
              //             offset: Offset(0, 3),
              //             color: Colors.grey,
              //             spreadRadius: 1,
              //             blurRadius: 6)
              //       ],color: Colors.white
              //   ),
              // ),
              // SizedBox(
              //   width: 20,
              // ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name != null
                            ? widget.name.toUpperCase()
                            : "NAME",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "ID : ${widget.orderid != null ? widget.orderid : ""}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(widget.count != null ? widget.count : "0"
                              // style: TextStyle(fontSize: 18),
                              ),
                          Text(
                            "items",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("|"),
                          SizedBox(
                            width: 10,
                          ),
                          Text("₹ "),
                          Text(widget.price != null ? widget.price : "00",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget notificationButon() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 5, right: 10),
          width: 160,
          child: ElevatedButton(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.orderpickup == "Store Pickup"
                        ? "Delivered"
                        : "Order Picked",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                isApiCallProcess = true;
              });
              if (widget.orderpickup == "Home Delivery") {
                request.status = "Delivered";
                // Order Pickup
                UpForDeliveryStatusapi service = UpForDeliveryStatusapi();
                service.deliveryStatus(request, context).then((value) => {
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
              } else if (widget.orderpickup == "Store Pickup") {
                request.status = "Delivered";
                UpForDeliveryStatusapi service = UpForDeliveryStatusapi();
                service.deliveryStatus(request, context).then((value) => {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(value.msg),
                      )),
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
            style: ElevatedButton.styleFrom(primary: Colors.white),
          ),
        ),
      );

  Widget cancelButton() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(top: 5, right: 10),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                          isApiCallProcess = true;
                        });
              request.status = "Reverted";
              UpForDeliveryStatusapi service = UpForDeliveryStatusapi();
              service.deliveryStatus(request, context).then((value) => {
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
            child: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Cancel order",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(primary: Colors.white),
          ),
        ),
      );
}
