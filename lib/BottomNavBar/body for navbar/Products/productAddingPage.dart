import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Service%20section/productService.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/categorynameList.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productNameAndCategoryType.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/action_chip_data.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/dataFetching/subCategoryDataFetching.dart';
import 'package:mallu_vendor/dataFetching/subCategoryModelClass.dart';
import 'package:provider/provider.dart';

import '../../../dataStorage.dart';
import '../../../progressHud.dart';

class ProductAddingPage extends StatefulWidget {
  final String category;
  final String subCategoryName;

  ProductAddingPage({Key key, @required this.category, this.subCategoryName})
      : super(key: key);

  @override
  _ProductAddingPageState createState() => _ProductAddingPageState();
}

class _ProductAddingPageState extends State<ProductAddingPage> {
  TextEditingController nameCotroller = TextEditingController();
  TextEditingController mrpCotroller = TextEditingController();
  TextEditingController sellingCotroller = TextEditingController();
  TextEditingController qutCotroller = TextEditingController();
  TextEditingController desCotroller = TextEditingController();
  SubCategoryTypeDataModelClassReq reqs = SubCategoryTypeDataModelClassReq();

  String mrp,
      sellingPrice,
      quantity,
      unit,
      productDetails,
      subCategory,
      subCategorys,
      productName;

  bool nextButtonClick = false;
  final double spacing = 3;
  final List<ActionChipData> actionChips = CategoryNameList.all;
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  String vendorToken = "";
  String vendorId = "";
  //image
  final ImagePicker _picker = ImagePicker();
  PickedFile _pickedImage;
  // File pickedImages;
  //image
  @override
  void initState() {
    reqs.category = widget.category;
    reqs.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    reqs.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;
    vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;
    vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    // final tokens =
    //     Provider.of<ProductNameAndCategoryTypeProvider>(context);
    final producttDataProvider = Provider.of<MapDataProvider>(context);
    producttDataProvider.changeProductLoadingIconValue(true);
    // final dataProviders = Provider.of<StoreNameAndTypeProvider>(context);
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Add products",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.blue,
        brightness: Brightness.dark,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white])),
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: productAddingSection(
                          producttDataProvider, dataProvider,producttDataProvider),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container()
            // Column(
            //   children: [
            //     Row(
            //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //           width: MediaQuery.of(context).size.width*.4,
            //           child: ElevatedButton(onPressed: (){
            //             nameCotroller.clear();
            //             mrpCotroller.clear();
            //             desCotroller.clear();
            //             sellingCotroller.clear();
            //             qutCotroller.clear();
            //           }, child:Text("clear all fields"))),
            //         SizedBox(width: 30,),
            //         Container(
            //           width: MediaQuery.of(context).size.width*.4,
            //           child: ElevatedButton(onPressed: _pickedImage != null
            //   ? () async {
            //       if (_formKey.currentState.validate()) {
            //         setState(() {
            //           isApiCallProcess = true;
            //         });
            //         if (widget.subCategoryName != null) {
            //           ProductServicerequests request =
            //               new ProductServicerequests();
            //           request.subCategoty = widget.subCategoryName;
            //           request.category = widget.category;
            //           request.desc = productDetails;
            //           request.mrp = mrp;
            //           request.productname = productName;
            //           request.quantity = quantity;
            //           request.sellingprice = sellingPrice;
            //           request.unit = unit != null ? unit : "piece";
            //           request.vendorToken = this.vendorToken;
            //           request.vendorId = this.vendorId;
            //           // dataProviders
            //           print(request.toJson());
            //           print(request.toHeader());
            //            MultyPartProductService service =
            //               MultyPartProductService();
            //           // print("print 2222222222222222222222222222222222${_pickedImage.path.split(".").last}");
            //           var responce = await service.multypart(
            //               request, _pickedImage.path.toString());
            //           print(_pickedImage.path);
            //           print(responce);
            //           if (responce == 200) {
            //             setState(() {
            //               isApiCallProcess = false;
            //               producttDataProvider
            //                   .changeProductLoadingIconValue(true);
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductAddingPage(category:widget.category,subCategoryName: widget.subCategoryName!=null? widget.subCategoryName:"",)),
            //               );
            //             });
            //           } else {
            //             setState(() {
            //               isApiCallProcess = false;
            //             });
            //             print(responce);
            //           }
            //         } else {
            //           ProductServicerequest reqses =
            //               new ProductServicerequest();
            //           reqses.category = widget.category;
            //           reqses.desc = productDetails;
            //           reqses.mrp = mrp;
            //           reqses.productname = productName;
            //           reqses.quantity = quantity;
            //           reqses.sellingprice = sellingPrice;
            //           reqses.unit = unit != null ? unit : "piece";
            //           reqses.vendorToken = this.vendorToken;
            //           reqses.vendorId = this.vendorId;
            //           MultyPartProductServices servic =
            //               new MultyPartProductServices();
            //               var responce = await servic.multypart(
            //              reqses, _pickedImage.path.toString());
            //           print(_pickedImage.path);
            //           print(responce);
            //           if (responce == 200) {
            //             setState(() {
            //               isApiCallProcess = false;
            //               producttDataProvider
            //                   .changeProductLoadingIconValue(true);
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProductAddingPage(category:widget.category,subCategoryName: widget.subCategoryName,)),
            //               );
            //             });
            //           } else {
            //             setState(() {
            //               isApiCallProcess = false;
            //             });
            //             print(responce);
            //           }
            //         }
            //       }
            //     }
            //   : null, child:Text("Add new Product"))),
            //       ],
            //     ),

            //     Padding(
            //         padding: const EdgeInsets.only(bottom: 5),
            //         child: addProductButton(context, producttDataProvider)),
            //   ],
            // ),
          )
        ],
      ),
    );
  }

  Widget imageSection() =>
      Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        SizedBox(
          width: 160,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 6, offset: Offset(0, 3))
                  ]),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: _pickedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.file(
                          File(_pickedImage.path),
                          fit: BoxFit.fill,
                          height: 160,
                          width: 160,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(70)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.category,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            showDialogBox(context);
          },
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      ]);

  Widget productAddingSection(produxtDataProvider, dataProvider,producttDataProvider) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 120, bottom: 25),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 40,
                      bottom: 40,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: []),
                    child: productDetailsAdd(dataProvider,producttDataProvider)),
                Container(child: imageSection()),
              ],
            )
          ],
        ),
      );

  Widget productDetailsAdd(dataProvider,producttDataProvider) => Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: nameCotroller,
                validator: (val) {
                  if (val.length < 2) {
                    return "enter the product name";
                  } else {
                    return null;
                  }
                },
                // initialValue: widget.productName,
                decoration: InputDecoration(labelText: "Product Name"),
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.productName = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Product category"),
                readOnly: true,
                initialValue: widget.category,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(labelText: "SubCategory name"),
                readOnly: true,
                initialValue: widget.subCategoryName != null
                    ? widget.subCategoryName
                    : "Not Added SubCategory",
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: mrpCotroller,
                      validator: (val) {
                        if (val.length < 1) {
                          return "required field";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: "MRP ", prefixText: "₹ "),
                      onChanged: (val) {
                        setState(() {
                          this.mrp = val.toString().trim();
                        });
                      },
                    ),
                  ),
                  flex: 10,
                  fit: FlexFit.loose,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: sellingCotroller,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.length < 1) {
                          return "required field";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Selling Price", prefixText: "₹ "),
                      onChanged: (val) {
                        setState(() {
                          this.sellingPrice = val;
                        });
                      },
                    ),
                  ),
                  flex: 10,
                  fit: FlexFit.loose,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: qutCotroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Quantity"),
                      validator: (val) {
                        if (val.length < 1) {
                          return "required field";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          this.quantity = val;
                        });
                      },
                    ),
                  ),
                  flex: 10,
                  fit: FlexFit.loose,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      // initialValue: unit!=null?unit:"Piece",
                      readOnly: true,
                      onTap: () {
                        addUnitDialog(context, dataProvider)
                            .then((value) => setState(() {
                                  this.unit = value;
                                }));
                      },
                      decoration: InputDecoration(
                          // labelText: "Unit",
                          hintText: unit != null ? unit : "Unit"),
                    ),
                  ),
                  flex: 10,
                  fit: FlexFit.loose,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: TextFormField(
                controller: desCotroller,
                key: Key("20"),
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                maxLines: 3,
                
                onChanged: (val) {
                  setState(() {
                    this.productDetails = val;
                  });
                },
                decoration: InputDecoration(
                    hintText: productDetails != null
                        ? productDetails
                        : "Product Details"),
              ),
            ),
//22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222


Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*.3,
                      child: ElevatedButton(onPressed: (){
                        nameCotroller.clear();
                        mrpCotroller.clear();
                        desCotroller.clear();
                        sellingCotroller.clear();
                        qutCotroller.clear();
                      }, child:Text("Cancel"))),
                    SizedBox(width: 30,),
                    Container(
                      width: MediaQuery.of(context).size.width*.4,
                      child: ElevatedButton(onPressed: _pickedImage != null
              ? () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    if (widget.subCategoryName != null) {
                      ProductServicerequests request =
                          new ProductServicerequests();
                      request.subCategoty = widget.subCategoryName;
                      request.category = widget.category;
                      request.desc = productDetails!=null?productDetails:" ";
                      request.mrp = mrp;
                      request.productname = productName;
                      request.quantity = quantity;
                      request.sellingprice = sellingPrice;
                      request.unit = unit != null ? unit : "piece";
                      request.vendorToken = this.vendorToken;
                      request.vendorId = this.vendorId;
                      // dataProviders
                      print(request.toJson());
                      print(request.toHeader());
                       MultyPartProductService service =
                          MultyPartProductService();
                      // print("print 2222222222222222222222222222222222${_pickedImage.path.split(".").last}");
                      var responce = await service.multypart(
                          request, _pickedImage.path.toString());
                      print(_pickedImage.path);
                      print(responce);
                      if (responce == 200) {
                        setState(() {
                          isApiCallProcess = false;
                          producttDataProvider
                              .changeProductLoadingIconValue(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAddingPage(category:widget.category,subCategoryName: widget.subCategoryName!=null? widget.subCategoryName:"",)),
                          );
                        });
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        print(responce);
                      }
                    } else {
                      ProductServicerequest reqses =
                          new ProductServicerequest();
                      reqses.category = widget.category;
                      reqses.desc =  productDetails!=null?productDetails:" ";
                      reqses.mrp = mrp;
                      reqses.productname = productName;
                      reqses.quantity = quantity;
                      reqses.sellingprice = sellingPrice;
                      reqses.unit = unit != null ? unit : "piece";
                      reqses.vendorToken = this.vendorToken;
                      reqses.vendorId = this.vendorId;
                      MultyPartProductServices servic =
                          new MultyPartProductServices();
                          var responce = await servic.multypart(
                         reqses, _pickedImage.path.toString());
                      print(_pickedImage.path);
                      print(responce);
                      if (responce == 200) {
                        setState(() {
                          isApiCallProcess = false;
                          producttDataProvider
                              .changeProductLoadingIconValue(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAddingPage(category:widget.category,subCategoryName: widget.subCategoryName,)),
                          );
                        });
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        print(responce);
                      }
                    }
                  }
                }
              : null, child:Text("Add new one"))),
                  ],
                ),

                Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: addProductButton(context, producttDataProvider)),
              ],
            ),


//22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222





            // TextButton(
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) => AlertDialog(
            //                 title: Text("Add Variants"),
            //                 content: TextFormField(
            //                   key: Key("6"),
            //                   controller: customCotroller,
            //                 ),
            //               ));
            //     },
            //     child: Text(
            //       "+ ADD VARIANTS",
            //       style: TextStyle(color: Colors.blue[800]),
            //     ))
          ],
        ),
      );
  Widget addProductButton(context, producttDataProvider) => Container(
        width: MediaQuery.of(context).size.width * .95,
        child: ElevatedButton(
          child: Container(
            child: Text(
              "Finish",
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: _pickedImage != null
              ? () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    if (widget.subCategoryName != null) {
                      ProductServicerequests request =
                          new ProductServicerequests();
                      request.subCategoty = widget.subCategoryName;
                      request.category = widget.category;
                      request.desc =  productDetails!=null?productDetails:" ";
                      request.mrp = mrp;
                      request.productname = productName;
                      request.quantity = quantity;
                      request.sellingprice = sellingPrice;
                      request.unit = unit != null ? unit : "piece";
                      request.vendorToken = this.vendorToken;
                      request.vendorId = this.vendorId;
                      // dataProviders
                      print(request.toJson());
                      print(request.toHeader());
                      MultyPartProductService service =
                          MultyPartProductService();
                      // print("print 2222222222222222222222222222222222${_pickedImage.path.split(".").last}");
                      var responce = await service.multypart(
                          request, _pickedImage.path.toString());
                      print(_pickedImage.path);
                      print(responce);
                      if (responce == 200) {
                        setState(() {
                          isApiCallProcess = false;
                          producttDataProvider
                              .changeProductLoadingIconValue(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar(sections: 1,)),
                          );
                        });
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        print(responce);
                      }
                    } else {
                      ProductServicerequest reqses =
                          new ProductServicerequest();
                      reqses.category = widget.category;
                      reqses.desc =  productDetails!=null?productDetails:" ";
                      reqses.mrp = mrp;
                      reqses.productname = productName;
                      reqses.quantity = quantity;
                      reqses.sellingprice = sellingPrice;
                      reqses.unit = unit != null ? unit : "piece";
                      reqses.vendorToken = this.vendorToken;
                      reqses.vendorId = this.vendorId;
                      MultyPartProductServices servic =
                          new MultyPartProductServices();
                          var responce = await servic.multypart(
                         reqses, _pickedImage.path.toString());
                      print(_pickedImage.path);
                      print(responce);
                      if (responce == 200) {
                        setState(() {
                          isApiCallProcess = false;
                          producttDataProvider
                              .changeProductLoadingIconValue(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar(sections: 1,)),
                          );
                        });
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        print(responce);
                      }
                    }
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(primary: Colors.black),
        ),
      );

  Widget categoryTypes(context, dataProvider) => Center(
        child: Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: actionChips
              .map((actionChip) => ActionChip(
                  backgroundColor: Colors.grey[200],
                  label: Text(actionChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // dataProvider.storeTypeOtherButton.value=false;
                    Navigator.of(context).pop(actionChip.label.toString());
                    dataProvider.changeCategoryTypeselection(
                        actionChip.label.toString());
                  }))
              .toList(),
        ),
      );

  Future<String> addUnitDialog(BuildContext context, dataProvider) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Unit"),
              // content: TextFormField(
              //   controller: customCotroller,
              // ),
              actions: <Widget>[categoryTypes(context, dataProvider)],
            ));
  }

  // Future<String> productDetailPopup(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Product Details"),
  //             content: TextFormField(
  //                 key: Key("12"), controller: customCotroller, maxLines: 3),
  //             actions: <Widget>[
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(customCotroller.text.toString());
  //                 },
  //                 child: Text("Add Product Details"),
  //               )
  //             ],
  //           ));
  // }

  Future<String> addSubCategory(
      {BuildContext context,
      String mrp,
      String sellingPrice,
      String quantity,
      String unit,
      String productDetails,
      String productname,
      String category,
      String subCategoty,
      StoreNameAndTypeProvider dataProviders,
      MapDataProvider producttDataProvider}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "   Add sub category Name   ",
                    textAlign: TextAlign.center,
                  )),
              content: Column(
                children: [
                  TextField(
                    key: Key("123"),
                    readOnly: false,
                    decoration: InputDecoration(
                        hintText: subCategorys != null
                            ? subCategory
                            : "add subcategory Name"),
                    onChanged: (val) {
                      setState(() {
                        this.subCategorys = val;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      addSubCategorys(
                        context: context,
                      ).then((value) => {
                            setState(() {
                              print(value);
                              this.subCategorys = value;
                            })
                          });
                      // );
                      print(
                          "$mrp, $sellingPrice, $quantity, $unit $productname");
                    },
                    child: Text("choose sub Category from List"),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        ProductServicerequests req =
                            new ProductServicerequests();

                        req.category = widget.category;
                        req.desc = productDetails;
                        req.mrp = mrp;
                        req.subCategoty =
                            subCategorys != null ? subCategorys : ".";
                        req.productname = productName;
                        req.quantity = quantity;
                        req.sellingprice = sellingPrice;
                        req.unit = unit != null ? unit : "piece";
                        req.vendorId = vendorId;
                        req.vendorToken = vendorToken;
                        print(
                            "1222222222222222222222222222222222222222222222 ${req.toJson()}");
                        print(req.toHeader());
                        MultyPartProductService serv =
                            MultyPartProductService();
                        var services = await serv.multypart(
                            req, _pickedImage.path.toString());
                        if (services == 200) {
                          producttDataProvider
                              .changeProductLoadingIconValue(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar(sections: 1,)),
                          );
                        } else {
                          print(services);
                        }
                      },
                      child: Text("Add Product To shelf"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar( sections: 1,)),
                      );
                      print(
                          "$mrp, $sellingPrice, $quantity, $unit $productname");
                    },
                    child: Text("S K I P"),
                  ),
                ],
              ),
              actions: <Widget>[
                // Container(
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(primary: Colors.black),
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => BottomNavBar()),
                //       );
                //       print(
                //           "$mrp, $sellingPrice, $quantity, $unit $productname $categorySubtype");
                //     },
                //     child: Text("Add Product To shelf"),
                //   ),
                // ),
              ],
            ));
  }

  Future<String> addSubCategorys({
    BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add "),
              actions: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: FutureBuilder<SubCategoryModelClass>(
                        future: SubCategoryDataFetching().getStoreType(
                          reqs,
                        ),
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          if (snapshot.hasData) {
                            // return Text(data.data.storetype);
                            return ListView.builder(
                              // controller: widget.scrollController,
                              itemCount: data.data.length,
                              itemBuilder: (context, index) {
                                final usersData = data.data[index].subcategory;
                                return Wrap(
                                  children: [
                                    Center(
                                      child: ActionChip(
                                        label: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child:
                                                Center(child: Text(usersData))),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context)
                                                .pop(usersData.toString());
                                          });
                                        },
                                        // avatar: Icon(Icons.select_all),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: const CircularProgressIndicator());
                          }
                        }),
                  ),
                )
              ],
            ));
  }

  showDialogBox(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('From camara'),
                    leading: Icon(Icons.camera_alt,),
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

  imageLoader(ImageSource source,context) async {
    final picked = await _picker.getImage(source: source);
    if (picked != null) {
      // compressImage(File(picked.path));
      setState(() {
        _pickedImage = picked;
      });
      Navigator.pop(context);
    }
    
  }

  // void compressImage(File file) async {
  //   final filePath = file.path; //final filePath = file.absolute.path;
  //   final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  //   final splitted = filePath.substring(0, (lastIndex));
  //   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  //   final compressedImage = await FlutterImageCompress.compressAndGetFile(
  //       filePath, outPath,
  //       minWidth: 1000, minHeight: 1000, quality: 50);
  //   if (compressedImage != null) {
  //     setState(() {
  //       pickedImages = compressedImage;
  //     });
  //     print((await compressedImage.readAsBytes()).lengthInBytes.toString());
  //   } else {
  //     print("image is null");
  //   }
  // }
}

