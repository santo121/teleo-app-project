import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/License%20Editing%20services/licenseEditingServices.dart';
import 'package:mallu_vendor/dataStorage.dart';

import '../../../progressHud.dart';


class EditGstNum extends StatefulWidget {
  EditGstNum({Key key}) : super(key: key);

  @override
  _EditGstNumState createState() => _EditGstNumState();
}

class _EditGstNumState extends State<EditGstNum> {
  String gstNumber, fssaiNumber;
  LicenceEditingServicesRequest request = new LicenceEditingServicesRequest();
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    request.vtoken = DataStorage.getVendorToken().trim();
    request.id = DataStorage.getVendorId().trim();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Licence"),),
      body: Container(
        margin: EdgeInsets.only(top: 20,right: 20,left: 20),
        height: MediaQuery.of(context).size.height / 3,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.gstNumber = val;
                  });
                },
                decoration: InputDecoration(hintText: "GSTIN"),
                validator: (val) {
                  if (val.length < 15 || val.length > 16) {
                    return "enter your gst";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.fssaiNumber = val;
                  });
                },
                decoration: InputDecoration(hintText: "FSSAI"),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        this.isApiCallProcess = true;
                      });
                      request.gstNumber = this.gstNumber.trim();
                      request.fssai =
                          this.fssaiNumber != null ? this.fssaiNumber : "";
                      print(request.toJson());
                      print(request.toHeader());
                      LicenceEditingServices register =
                          new LicenceEditingServices();
                      register
                          .registerLicence(request, context)
                          .then((value) => {
                                if (value.error != null)
                                  {
                                    setState(() {
                                      this.isApiCallProcess = false;
                                    }),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(value.error),
                                    ))
                                  }
                                else if (value.msg != null)
                                  {
                                    setState(() {
                                      this.isApiCallProcess = false;
                                    }),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(value.msg),
                                    )),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNavBar(sections: 3,)),
                                    )
                                  }
                              });
                    }
                  },
                  child: Text("Save Licence"))
            ],
          ),
        )),
    );
    
    
  }
}
