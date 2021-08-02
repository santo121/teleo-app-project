import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/upForDeliverySectionOrederWidget.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'History Apis/FullfiledApiServiceModel.dart';
import 'History Apis/fullfiledApiService.dart';

class FullfilledSection extends StatefulWidget {
  FullfilledSection({Key key}) : super(key: key);

  @override
  _FullfilledSectionState createState() => _FullfilledSectionState();
}

class _FullfilledSectionState extends State<FullfilledSection> {

FullfiledApiServicequest request = new FullfiledApiServicequest();

@override
void initState() { 
  super.initState();
  request.id=DataStorage.getVendorId();
  request.vtoken = DataStorage.getVendorToken();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
         decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),color: Colors.grey[200]),
         child:FutureBuilder<FullfiledApiServiceModel>(
          future: FullfiledApiService().fullfiledOreders(request, context),
          builder: (contect, snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data.data.length == 0) {
                return NoFullFilledOrders();
              } else {
                return ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final userdata = data.data[index];
                      return FullfilledSectionWidget(
                        userName:userdata.name,
                        orderid:userdata.orderid,
                        phoneNum: userdata.phonenumber,
                        total: userdata.total.toString(),

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

class FullfilledSectionWidget extends StatefulWidget {
  FullfilledSectionWidget({Key key,this.orderid,this.phoneNum,this.userName,this.total}) : super(key: key);
  final String userName,orderid,phoneNum,total;
  @override
  _FullfilledSectionWidgetState createState() => _FullfilledSectionWidgetState();
}

class _FullfilledSectionWidgetState extends State<FullfilledSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(5)
      ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(widget.userName,style: TextStyle(fontSize: 18,color: Colors.green),),
             SizedBox(width: 10,),
             Icon(Icons.check_circle_outline_outlined,color: Colors.green,)
           ],
         ),
         
         Row(
           children: [
             Text("Phone Number :"),
             TextButton(onPressed:(){
               customLaunch('tel:+91 ${widget.phoneNum}');
             }, child:Text(widget.phoneNum,style: TextStyle(color: Colors.green),),),
           ],
         ),
         
         Text("Order id : ${widget.orderid}"),
         SizedBox(height: 5,),
        //  Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //    children: [
        //      Row(
        //        children: [
        //          Text("Date : "),
        //          Text("09/12/2020",style: TextStyle(color: Colors.green),),
        //        ],
        //      ),
        //      Row(
        //        children: [
        //          Text("Time : "),
        //          Text("20:43",style: TextStyle(color: Colors.green),),
        //        ],
        //      ),
        //    ],
        //  ),
       ],)
    );
  }
   void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }
}


class NoFullFilledOrders extends StatelessWidget {
  const NoFullFilledOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "You don't fullfilled any Orders",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
     
    );
  }
 
}