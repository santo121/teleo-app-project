import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/action_chip_data.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:mallu_vendor/deleteProduct.dart';
import '../../../../progressHud.dart';
import '../../../../updataProduct.dart';
import '../categorynameList.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName,
      category,
      subCategory,
      mrp,
      sellingPrice,
      quantity,
      piece,
      image,
      productId,
      productDetails;
  ProductDetailsPage(
      {Key key,
      @required this.category,
      @required this.productName,
      @required this.subCategory,
      @required this.image,
      @required this.mrp,
      @required this.piece,
      @required this.productDetails,
      @required this.quantity,
      @required this.sellingPrice,
      @required this.productId})
      : super(key: key);
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  PickedFile _pickedFile;
  UpdateProductRequest update = new UpdateProductRequest();
  UpdateProductRequestWithoutSub updatewithoutSub =
      new UpdateProductRequestWithoutSub();
  final _formKey = GlobalKey<FormState>();
  DeleteProductReq request = new DeleteProductReq();
  bool stock = true;
  String productName,
      category,
      subCategory,
      mrp,
      sellingPrice,
      quantity,
      piece,
      image,
      productDetails;
  @override
  void initState() {
    request.id =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    request.vtoken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;
    update.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    update.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;

    updatewithoutSub.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    updatewithoutSub.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;

    super.initState();
  }

  final double spacing = 3;
  String unit;
  final List<ActionChipData> actionChips = CategoryNameList.all;

  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uisetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uisetup(BuildContext context) {
    // this.unit = widget.piece;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:stock?Colors.green:Colors.red,
          title: Text(widget.productName.toUpperCase()),
          actions: [
            Center(child: Text("Stock")),
            stockvalue()],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        imageSection(),
                        textFields(),
                        deletButton(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*.8,
                            child: ElevatedButton(
                      onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (widget.subCategory != null ||
                                  this.subCategory != null) {
                                setState(() {
                                  this.isApiCallProcess = true;
                                });
                                update.category = this.category != null
                                    ? this.category
                                    : widget.category;
                                update.productname = this.productName != null
                                    ? this.productName
                                    : widget.productName;
                                update.subCategory = this.subCategory != null
                                    ? this.subCategory
                                    : widget.subCategory;
                                update.unit =
                                    this.unit != null ? this.unit : widget.piece;
                                update.sellingprice = this.sellingPrice != null
                                    ? this.sellingPrice
                                    : widget.sellingPrice;
                                update.mrp =
                                    this.mrp != null ? this.mrp : widget.mrp;
                                update.quantity = this.quantity != null
                                    ? this.quantity
                                    : widget.quantity;
                                update.desc = this.productDetails != null
                                    ? this.productDetails
                                    : widget.productDetails;
                                print(update.toJson());
                                UpdataProductServices updateService =
                                    UpdataProductServices();
                                updateService
                                    .update(update, context,
                                        productId: widget.productId.toString())
                                    .then((value) => {
                                          setState(() {
                                            this.isApiCallProcess = false;
                                          }),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar(sections: 1,)),
                                          ),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("Product updated"),
                                          )),
                                        });
                              } else if (widget.subCategory == null ||
                                  this.subCategory == null) {
                                updatewithoutSub.category = this.category != null
                                    ? this.category
                                    : widget.category;
                                updatewithoutSub.productname =
                                    this.productName != null
                                        ? this.category
                                        : widget.productName;
                                updatewithoutSub.unit =
                                    this.unit != null ? this.unit : widget.piece;
                                updatewithoutSub.sellingprice =
                                    this.sellingPrice != null
                                        ? this.sellingPrice
                                        : widget.sellingPrice;
                                updatewithoutSub.mrp =
                                    this.mrp != null ? this.mrp : widget.mrp;
                                updatewithoutSub.quantity = this.quantity != null
                                    ? this.quantity
                                    : widget.quantity;
                                updatewithoutSub.desc = this.productDetails != null
                                    ? this.productDetails
                                    : widget.productDetails;
                                print(updatewithoutSub.toJson());
                                UpdataProductServicesWithoutSub updateService =
                                    UpdataProductServicesWithoutSub();
                                updateService
                                    .updateWithoutSub(updatewithoutSub, context,
                                        productId: widget.productId.toString())
                                    .then((value) => {
                                          setState(() {
                                            this.isApiCallProcess = false;
                                          }),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar(sections: 1,)),
                                          ),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("Product updated"),
                                          )),
                                        });
                              }
                            }
                      },
                      child: Text("Update product")),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ));
  }

  Widget imageSection() => Container(
        margin: EdgeInsets.only(top: 20, left: 20),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              border: Border.all(width: .5),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(widget.image != null ? widget.image : ""),
                  fit: BoxFit.cover)),
          child: Center(
              child: Icon(
                widget.image !=null?null:
            Icons.camera_alt,
            color: Colors.grey,
          )),
        ),
      );

  Widget textFields() => Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: Key("3"),
                initialValue: widget.productName,
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                validator: (val) {
                  if (val.length < 4) {
                    return "please add Product name";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    this.productName = val;
                  });
                },
                decoration: InputDecoration(hintText: "Product Name"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.category,
                key: Key("8"),
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                validator: (val) {
                  if (val.length < 4) {
                    return "please add Category";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    this.category = val;
                  });
                },
                decoration: InputDecoration(hintText: "Category"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.subCategory,
                key: Key("2"),
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                onChanged: (val) {
                  setState(() {
                    this.subCategory = val;
                  });
                },
                decoration: InputDecoration(hintText: "Subategory"),
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
                        initialValue: widget.mrp,
                        validator: (val) {
                          if (val.length < 1) {
                            return "required field";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "MRP ", prefixText: "₹ "),
                        onChanged: (val) {
                          setState(() {
                            this.mrp = val;
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
                        initialValue: widget.sellingPrice,
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
                        initialValue: widget.quantity,
                        validator: (val) {
                          if (val.length < 1) {
                            return "required field";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Quantity ",
                        ),
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
                        readOnly: true,
                        onTap: () {
                          addUnitDialog(context).then((value) => setState(() {
                                this.unit = value;
                              }));
                        },
                        // initialValue: unit,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: unit != null ? unit : widget.piece,
                        ),
                        onChanged: (val) {
                          setState(() {
                            this.unit = val;
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
              TextFormField(
                initialValue: widget.productDetails,
                key: Key("1"),
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                maxLines: 3,
                validator: (val) {
                  if (val.length < 4) {
                    return "please add some discription";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    this.productDetails = val;
                  });
                },
                decoration: InputDecoration(hintText: "Product Name"),
              ),
            ],
          ),
        ),
      );
  Widget deletButton() => Container(
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            onPressed: () {
              DeleteProductService delete = new DeleteProductService();
              delete.delete(request, widget.productId, context).then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar(sections: 1,)),
                    ),
                  );
            },
            child: Text(
              "Delete the Product",
              style: TextStyle(color: Colors.red),
            )),
      );

  Widget categoryTypes(context) => Center(
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
                  }))
              .toList(),
        ),
      );

  Future<String> addUnitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Unit"),
              actions: <Widget>[categoryTypes(context)],
            ));
  }
  Widget stockvalue() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
          activeColor: Colors.white,
            value: stock,
            onChanged: (val) {
              setState(() {
                this.stock = val;
              });
            }),
      );
}
