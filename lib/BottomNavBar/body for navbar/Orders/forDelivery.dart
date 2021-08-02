import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/upForDeliverySectionOrederWidget.dart';
import 'package:mallu_vendor/dataStorage.dart';

import 'OrdersSectionApi/upForDelivery/UpforDeliveryApiServiceModel.dart';
import 'OrdersSectionApi/upForDelivery/upforDeliveryApiService.dart';

class UpForDelivery extends StatefulWidget {
  UpForDelivery({Key key}) : super(key: key);

  @override
  _UpForDeliveryState createState() => _UpForDeliveryState();
}

class _UpForDeliveryState extends State<UpForDelivery> {
  UpforDeliveryApiServiceRequest req =new UpforDeliveryApiServiceRequest();
  @override
  void initState() { 
    super.initState();
    req.id=DataStorage.getVendorId();
    req.vtoken=DataStorage.getVendorToken();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: FutureBuilder<UpforDeliveryApiServiceModel>(
        future: UpforDeliveryApiService().deliverProducts(req, context),
        builder: (context, snapshot){
          final data=snapshot.data;
          if(snapshot.hasData){
            if (data.data.length == 0) {
                return NoupFordelivery();
              }else{
            return ListView.builder(
              itemCount: data.data.length,
              itemBuilder:(context,index){
                final userData = data.data[index];
                return UpForDeliverySectionOrderWidget( 
                  count: userData.count,
                  name: userData.name,
                  orderid: userData.orderid,
                  orderstatus: userData.orderstatus,
                  price: userData.total,
                  orderpickup: userData.orderpickup,
                );
              });}
          }
          else{
            return Center(
                        child: const CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
          }
        }
      )
    );
  }
}


class NoupFordelivery extends StatelessWidget {
  const NoupFordelivery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.face,color: Colors.white,),
              Text("You don't have any accepted orders",style: TextStyle(color: Colors.white,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}