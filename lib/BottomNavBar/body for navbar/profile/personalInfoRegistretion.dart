import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/personalInfoRegApi.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/profileMainPage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/profileimageuplodingApi.dart';
import 'package:mallu_vendor/dataStorage.dart';

import '../../../progressHud.dart';

class PersonalInfoRegistretion extends StatefulWidget {
  PersonalInfoRegistretion({Key key,this.address,this.gstnumber,this.postalcode,this.state,this.email,this.ownername,this.fssai,this.country,this.altphonenumber,this.city,this.image}) : super(key: key);
final String ownername,
      altphonenumber,
      email,
      address,
      city,
      state,
      postalcode,
      country,
      gstnumber,
      image,
      fssai;
  @override
  _PersonalInfoRegistretionState createState() =>
      _PersonalInfoRegistretionState();
}

class _PersonalInfoRegistretionState extends State<PersonalInfoRegistretion> {
  PersonalInfoRegReq req = new PersonalInfoRegReq();
  bool isApiCallProcess = false;
  ProfileImageUplodingApiRequest imdreq = new ProfileImageUplodingApiRequest();
  @override
  void initState() {
    super.initState();
    req.vToken = DataStorage.getVendorToken();
    req.id = DataStorage.getVendorId();
    imdreq.vendorId = DataStorage.getVendorId();
    imdreq.vendorToken = DataStorage.getVendorToken();
  }

  String ownername,
      altphonenumber,
      email,
      address,
      city,
      state,
      postalcode,
      country;
      
  final ImagePicker _picker = ImagePicker();
  PickedFile _pickedImage;
  File pickedImages;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Icon(Icons.insert_drive_file_rounded),
          SizedBox(
            width: 10,
          ),
          Text("Register Personal Info"),
        ],
      )),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              children: [
                Row(
                  children: [
                    imageSection(),
                  ],
                ),
                textFields()
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width * .8,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        req.ownername = this.ownername;
                        req.altphonenumber = this.altphonenumber;
                        req.email = this.email;
                        req.address = this.address;
                        req.city = this.city;
                        req.state = this.state;
                        req.postalcode = this.postalcode;
                        req.country = this.country;
                        
                        PersonalInfoRegApi service = new PersonalInfoRegApi();
                        service.personalReg(req).then((value) => {
                              print(value.msg.toString()),
                              print(value.error.toString()),
                              print(value.statuscode.toString()),
                              if (value.error != null)
                                {
                                  setState(() {
                                    isApiCallProcess = false;
                                  }),
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(value.error),
                                  )),
                                }
                              else if (value.msg != null)
                                {
                                  setState(() {
                                    isApiCallProcess = false;
                                  }),
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(value.msg),
                                  )),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavBar(sections: 3,)),
                                  ),
                                  setState(() async {
                                    await DataStorage.setaddress(
                                        address: address);
                                    await DataStorage.setaltphonenumber(
                                        altphonenumber: altphonenumber);
                                    await DataStorage.setcity(city: city);
                                    await DataStorage.setcountry(
                                        country: country);
                                    await DataStorage.setemail(email: email);
                                    // await DataStorage.setfassai(fassai: fssai);
                                    // await DataStorage.setgstnumber(
                                    //     gstnumber: gstnumber);
                                    await DataStorage.setownerName(
                                        ownerName: ownername);
                                    await DataStorage.setpostalcode(
                                        postalcode: postalcode);
                                    await DataStorage.setstate(state: state);
                                  }),
                                }
                              else
                                {
                                  setState(() {
                                    isApiCallProcess = false;
                                  }),
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("${value.msg},& ${value.error}"),
                                  )),
                                }
                            });
                      }
                    },
                    child: Text(" Register ")))
          ],
        ),
      ),
    );
  }

  Widget imageSection() => GestureDetector(
        onTap: () {
          showDialogBox(context);
        },
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child:
                   _pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            File(_pickedImage.path),
                            fit: BoxFit.fill,
                            height: 160,
                            width: 160,
                          ),
                        )
                      :widget.image!=null?ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            File(widget.image),
                            fit: BoxFit.fill,
                            height: 160,
                            width: 160,
                          ),
                        ):Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(70)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            _pickedImage != null
                ? ElevatedButton(
                    onPressed: () {
                      ProfileImageUplodingApi serv =
                          new ProfileImageUplodingApi();
                      serv.service(imdreq, _pickedImage.path).then((value) => {
                            if (value == 200)
                              {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("image updated"),
                                )),
                                setState(() async {
                                  // await DataStorage.setimageurl(
                                  //     imageurl: _pickedImage.path);
                                })
                              }
                            else
                              {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(value),
                                )),
                              }
                          });
                    },
                    child: Text("save picture"))
                : Container()
          ],
        ),
      );

  Widget textFields() => Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.ownername!=null?widget.ownername:null,
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.ownername = val;
                  });
                },
                decoration: InputDecoration(hintText: "Owner name"),
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.altphonenumber!=null?widget.altphonenumber:null,
                keyboardType: TextInputType.phone,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.altphonenumber = val;
                  });
                },
                decoration: InputDecoration(hintText: "secondary phone number"),
                validator: (val) {
                  if (val.length < 10) {
                    return "enter your Phone number";
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
                    this.email = val;
                  });
                },
                decoration: InputDecoration(hintText: "email"),
                initialValue: widget.email!=null?widget.email:null,
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your email id";
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
                    this.address = val;
                  });
                },
                decoration: InputDecoration(hintText: "address"),
                initialValue: widget.address!=null?widget.address:null,
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your address";
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
                    this.city = val;
                  });
                },
                decoration: InputDecoration(hintText: "city"),
                initialValue: widget.city!=null?widget.city:null,
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your city";
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
                    this.state = val;
                  });
                },
                decoration: InputDecoration(hintText: "state"),
                initialValue: widget.state!=null?widget.state:null,
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your state";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.postalcode = val;
                  });
                },
                decoration: InputDecoration(hintText: "postalcode"),
                initialValue: widget.postalcode!=null?widget.postalcode:null,
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your Postalcode";
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
                initialValue: widget.country!=null?widget.country:null,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.country = val;
                  });
                },
                decoration: InputDecoration(hintText: "country"),
                validator: (val) {
                  if (val.length <= 1) {
                    return "enter your country";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   readOnly: false,
              //   onChanged: (val) {
              //     setState(() {
              //       this.gstnumber = val;
              //     });
              //   },
              //   decoration: InputDecoration(hintText: "GSTIN"),
              //   initialValue: widget.gstnumber!=null?widget.gstnumber:null,
              //   validator: (val) {
              //     if (val.length < 15) {
              //       return "enter your gst";
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   readOnly: false,
              //   onChanged: (val) {
              //     setState(() {
              //       this.fssai = val;
              //     });
              //   },
              //   decoration: InputDecoration(hintText: "FSSAI"),
              //   initialValue: widget.fssai!=null?widget.fssai:null,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );

  showDialogBox(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('From camer'),
                    leading: Icon(Icons.camera_alt),
                    onTap: () {
                      imageLoader(ImageSource.camera,context);
                    },
                  ),
                  ListTile(
                    title: Text('From gallery'),
                    leading: Icon(Icons.image),
                    onTap: () {
                      imageLoader(ImageSource.gallery,context);
                    },
                  )
                ],
              ),
            ));
  }

  imageLoader(ImageSource source,BuildContext context) async {
    final picked = await _picker.getImage(source: source);
    if (picked != null) {
      // compressImage(File(picked.path));
      setState(() {
        _pickedImage = picked;
      });
    }
    Navigator.pop(context);
  }
}
