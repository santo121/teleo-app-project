import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/recievedDetailsPage.dart';

import '../../../../customPageRoute.dart';

class ReceivedSectionListingWidget extends StatefulWidget {
  ReceivedSectionListingWidget({Key key,@required this.itemCount,@required this.name,@required this.orderId,@required this.price,@required this.status}) : super(key: key);
  final String name,orderId,itemCount,price,status;

  @override
  _ReceivedSectionListingWidgetState createState() =>
      _ReceivedSectionListingWidgetState();
}

class _ReceivedSectionListingWidgetState
    extends State<ReceivedSectionListingWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        


        Navigator.push(
                          context,
                          CustomPageRoute(child:RecievedDetailsPage(orderId: widget.orderId,orderStatus:widget.status,name:widget.name,),direction: AxisDirection.right)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 10,right: 10),
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  color:widget.status.toString()!="accepted"? Colors.yellow[800]:Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 6)
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      widget.status.toString()!="accepted"?Icons.pending:Icons.check_circle,
                      color: Colors.white,
                    ),
                    Text(
                      widget.status!=null?widget.status:" ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detailsSection() => Container(
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
                      widget.name!=null?widget.name.toUpperCase():"Name",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Order ID : ${widget.orderId!=null?widget.orderId:"000@00"}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.itemCount!=null?widget.itemCount:"0"}/",
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
                        Text("${widget.price!=null?widget.price:"00"}/-",
                            style: TextStyle(
                                fontWeight: FontWeight.w500)),
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
      );
}
