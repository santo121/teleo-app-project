import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Manage%20Page/My%20Customers/My%20customers%20Services/myCustomerModelClass.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Manage%20Page/My%20Customers/MyCustomersWidget/myCustomersWidget.dart';
import 'package:mallu_vendor/dataStorage.dart';

import 'My customers Services/myCustomersApi.dart';

class MyCustomers extends StatefulWidget {
  MyCustomers({Key key}) : super(key: key);

  @override
  _MyCustomersState createState() => _MyCustomersState();
}

class _MyCustomersState extends State<MyCustomers> {
  MyCustomersApiRequestServices req = new MyCustomersApiRequestServices();
  @override
  void initState() {
    super.initState();
    req.id = DataStorage.getVendorId();
    req.vtoken = DataStorage.getVendorToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Customers"),
      ),
      body: FutureBuilder<MyCustomerModelClass>(
        future: MyCustomersApiService().customerContact(req, context),
        builder: (contect, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            if (data.data.length == 0) {
              return NoContacts();
            } else {
              return ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    final userdata = data.data[index];
                    return MycustomerWidget(
                      name: userdata.name,
                      phoneNumber: userdata.phonenumber,
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
      ),
    );
  }
  
}

class NoContacts extends StatelessWidget {
  const NoContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.face,
                color: Colors.black,
              ),
              Text(
                "You daon't have any customers",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
