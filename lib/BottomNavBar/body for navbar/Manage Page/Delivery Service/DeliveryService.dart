import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Manage%20Page/Delivery%20Service/Delivery%20Service%20Api/deliveryServiceApi.dart';
import 'package:mallu_vendor/dataStorage.dart';


class DeliveryServicePage extends StatefulWidget {
  DeliveryServicePage({Key key}) : super(key: key);

  @override
  _DeliveryServicePageState createState() => _DeliveryServicePageState();
}

class _DeliveryServicePageState extends State<DeliveryServicePage> {
  bool homeDeliveryStatusvalue = DataStorage.gethomeDelivery() != null
          ? DataStorage.gethomeDelivery()
          : true,
      delivery;
  bool pickFromStoreStatusvalue = DataStorage.getpickFromStore() != null
          ? DataStorage.getpickFromStore()
          : true,
      pickup;

  @override
  DeliveryServiceApiRequest request = DeliveryServiceApiRequest();
  void initState() {
    super.initState();
    this.request.id = DataStorage.getVendorId();
    this.request.vtoken = DataStorage.getVendorToken();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Are you going save this!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBar(
                              sections: 2,
                            )),
                  );
                },
              ),
              ElevatedButton(
                child: Text('save'),
                onPressed: () async {
                  request.homedelivery =
                      this.homeDeliveryStatusvalue.toString();
                  request.orderpickup =
                      this.pickFromStoreStatusvalue.toString();
                  print(request.toJson());
                  DeliveryServiceApi service = DeliveryServiceApi();
                  service.deliveryService(request, context).then((value) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(
                                    sections: 2,
                                  )),
                        ),
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text(value.msg),
                        // )),
                      });
                  await DataStorage.setpickFromStore(
                      pickFromStore: pickFromStoreStatusvalue);
                  await DataStorage.sethomeDelivery(
                      homeDelivery: homeDeliveryStatusvalue);
                },
              ),
            ],
          );
        });
  }

  Future<bool> _onBackPressedwithoutData() {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavBar(
                sections: 2,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: homeDeliveryStatusvalue != DataStorage.gethomeDelivery() ||
              pickFromStoreStatusvalue != DataStorage.getpickFromStore()
          ? _onBackPressed
          : _onBackPressedwithoutData,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("Delivery Service"),
        ),
        body: Container(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Pick from store",
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text("Enable it to pick from store"),
                trailing: pickFromStoreStatus(),
                // trailing: ,
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  "Home delivery",
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text("Enable it for Home Delivery"),
                trailing: homeDeliveryStatus(),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeDeliveryStatus() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            value: homeDeliveryStatusvalue,
            onChanged: (val) async {
              setState(() {
                homeDeliveryStatusvalue = val;
              });
            }),
      );
  Widget pickFromStoreStatus() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            value: pickFromStoreStatusvalue,
            onChanged: (val) async {
              setState(() {
                pickFromStoreStatusvalue = val;
              });
            }),
      );
}
