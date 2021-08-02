import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/getOrderModelClass.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/getOrderService.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/widgets%20for%20orders/receivedScetionListingWidget.dart';
import 'package:mallu_vendor/dataStorage.dart';

class RecivedPage extends StatefulWidget {
  RecivedPage({Key key}) : super(key: key);

  @override
  _RecivedPageState createState() => _RecivedPageState();
}

class _RecivedPageState extends State<RecivedPage> {
  GetOrderServicerequest request = new GetOrderServicerequest();
  @override
  void initState() {
    super.initState();
    request.id = DataStorage.getVendorId();
    request.vtoken = DataStorage.getVendorToken();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: FutureBuilder<GetOrderModelClass>(
          future: GetOrderService().getOrders(request, context),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data.data.length == 0) {
                return NoOrders();
              } else {
                return ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final userdata = data.data[index];
                      return ReceivedSectionListingWidget( 
                        itemCount: userdata.count,
                        name: userdata.name,
                        orderId: userdata.orderid,
                        price: userdata.total,
                        status: userdata.orderstatus,
                      );
                    });
              }
            }
            //  else if (snapshot.hasError) {
            //   return Center(
            //     child: Text("something went wrong"),
            //   );
            // } 
            else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ));
            }
          },
        ));
  }
}

class NoOrders extends StatelessWidget {
  const NoOrders({Key key}) : super(key: key);

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
              Text("You don't get any orders",style: TextStyle(color: Colors.white,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
