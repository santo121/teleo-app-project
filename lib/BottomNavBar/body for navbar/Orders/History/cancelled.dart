import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/upForDeliverySectionOrederWidget.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'History Apis/CancelledApiServiceModel.dart';
import 'History Apis/cancelledApiService.dart';

class CancelledSection extends StatefulWidget {
  CancelledSection({Key key}) : super(key: key);

  @override
  _CancelledSectionState createState() => _CancelledSectionState();
}

class _CancelledSectionState extends State<CancelledSection> {
  CancelledApiServicerequest request = new CancelledApiServicerequest();
  @override
  void initState() {
    super.initState();
    request.id = DataStorage.getVendorId();
    request.vtoken = DataStorage.getVendorToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
            color: Colors.grey[200]),
        child: FutureBuilder<CancelledApiServiceModel>(
          future: CancelledApiService().cancelledOreders(request, context),
          builder: (contect, snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data.data.length == 0) {
                return NoClancelledOrders();
              } else {
                return ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final userdata = data.data[index];
                      return CanceledSectionWidget(
                        productname:userdata.name,
                        orderid:userdata.orderid,
                        phoneNum: userdata.phonenumber,

                      );
                    });
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ));
            }
          },
        ));
  }
}

class CanceledSectionWidget extends StatefulWidget {
  CanceledSectionWidget({Key key,this.orderid,this.productname,this.itemCount,this.phoneNum}) : super(key: key);
 final String phoneNum,orderid,productname,itemCount;
  @override
  _CanceledSectionWidgetState createState() => _CanceledSectionWidgetState();
}

class _CanceledSectionWidgetState extends State<CanceledSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5), 
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productname,style: TextStyle(fontSize: 18,color: Colors.red)),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                )
              ],
            ),
            Row(
           children: [
             Text("Phone Number :"),
             TextButton(onPressed:(){
               customLaunch('tel:+91 ${widget.phoneNum}');
             }, child:Text(widget.phoneNum,style: TextStyle(color: Colors.red),),),
           ],
         ),
           
            Text("Order id: ${widget.orderid}"),
        //     Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //    children: [
        //      Row(
        //        children: [
        //          Text("Date : "),
        //          Text("09/12/2020",style: TextStyle(color: Colors.red),),
        //        ],
        //      ),
        //      Row(
        //        children: [
        //          Text("Time : "),
        //          Text("20:43",style: TextStyle(color: Colors.red),),
        //        ],
        //      ),
        //    ],
        //  ),
          ],
        ));
  }
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }
}

class NoClancelledOrders extends StatelessWidget {
  const NoClancelledOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
            color: Colors.grey[200]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.face,
                color: Colors.black,
              ),
              Text(
                "You don't canceled any Orders",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      );
 
  }
}
