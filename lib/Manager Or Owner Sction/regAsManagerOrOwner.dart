import 'package:flutter/material.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storenameAndType.dart';
import 'package:mallu_vendor/dataStorage.dart';

class RegAsManagerOrOwner extends StatefulWidget {
final String vendorToken;
final String vendorIdFromOtp;
RegAsManagerOrOwner({this.vendorToken,this.vendorIdFromOtp});

  @override
  _RegAsManagerOrOwnerState createState() => _RegAsManagerOrOwnerState();
}

class _RegAsManagerOrOwnerState extends State<RegAsManagerOrOwner> {
String vendorId ="";
  String vendorToken ="";
@override
  void initState() {
    vendorId = DataStorage.getVendorId()??null;
    vendorToken = DataStorage.getVendorToken()??null;
    super.initState();
  }
  

  @override
  Widget build(BuildContext contect) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreNameAndType(vendorToken: vendorToken,vendorIdFromOtp: vendorId,)),
                      );
                    },
                    child: Text(
                      "Register As Owner",
                      style: TextStyle(fontSize: 24),
                    ))),
            // SizedBox(
            //   height: 20,
            // ),
            // SizedBox(
            //     width: MediaQuery.of(context).size.width * .8,
            //     height: MediaQuery.of(context).size.height * .4,
            //     child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(primary: Colors.black),
            //         onPressed: () {},
            //         child: Text("Register As Manager",
            //             style: TextStyle(fontSize: 24)))),
          ],
        ),
      ),
    );
  }
}
