import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/product%20find%20by%20category%20and%20sub%20Api/productPriceEditingApi.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/productDetailsPage.dart';
import 'package:mallu_vendor/dataFetching/productFindByCatSubCatModel.dart';
import 'package:mallu_vendor/dataFetching/productFindingByCat&SubCat.dart';
import 'package:mallu_vendor/dataStorage.dart';

import '../productAddingPage.dart';

class ProductFindedByCatAndSubCatSection extends StatefulWidget {
  ProductFindedByCatAndSubCatSection(
      {Key key, @required this.category, this.subCategory})
      : super(key: key);
  final String category, subCategory;

  @override
  _ProductFindedByCatAndSubCatSectionState createState() =>
      _ProductFindedByCatAndSubCatSectionState();
}

class _ProductFindedByCatAndSubCatSectionState
    extends State<ProductFindedByCatAndSubCatSection> {
  ProductFindingByCatSubCatReq req = new ProductFindingByCatSubCatReq();
  ProductPriceEditingApirequest editReq = new ProductPriceEditingApirequest();
  bool editPrice = false;
  String editedPrice;
  @override
  void initState() {
    req.vendorId = DataStorage.getVendorId();
    req.vendorToken = DataStorage.getVendorToken();
    editReq.id = DataStorage.getVendorId();
    editReq.vtoken = DataStorage.getVendorToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (editPrice == true) {
                  setState(() {
                    editPrice = false;
                  });
                } else {
                  setState(() {
                    editPrice = true;
                  });
                }
              },
              child: Text(editPrice ? "Back" : "Edit Price"),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: categoryScreen(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editPrice != true
                ? Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAddingPage(
                                      category: widget.category,
                                      subCategoryName: widget.subCategory,

                                      // productName: productName,
                                    )),
                          );
                        },
                        child: Text("Add products")),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget categoryScreen() => GestureDetector(
        child: FutureBuilder<ProductFindByCatSubCatModel>(
            future: ProductFindingByCatSubCat().getProduct(
                req, widget.category.toString(), widget.subCategory.toString()),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                // return Text(data.data.storetype);
                return ListView.builder(
                  // controller: widget.scrollController,
                  // controller: widget.scrollController,
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    final usersData = data.data[index];

                    return productContainer(
                        category: usersData.category,
                        image: usersData.imagelocation,
                        prise: usersData.mrp.toString(),
                        sellingprice: usersData.sellingprice.toString(),
                        productDetails: usersData.description,
                        productId: usersData.productid,
                        productName: usersData.productname,
                        quantity: usersData.quantity.toString(),
                        subCategory: usersData.subcategory,
                        unit: usersData.unit);
                  },
                );
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            }),
      );

  Widget productContainer(
          {String productName,
          prise,
          unit,
          quantity,
          sellingprice,
          category,
          productDetails,
          subCategory,
          image,
          productId}) =>
      GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ProductDetailsPage(
          //             productName: productName.toUpperCase(),
          //             mrp: prise,
          //             sellingPrice: sellingprice,
          //             quantity: quantity,
          //             piece: unit,
          //             category: category,
          //             productDetails: productDetails,
          //             subCategory: subCategory,
          //             image: image,
          //             productId: productId,
          //           )),
          // );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                // boxShadow: [
                //   BoxShadow(offset: Offset(0, 3), blurRadius: 6, spreadRadius: .1)
                // ]
              ),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        spreadRadius: .05,
                                        color: Colors.grey)
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          image != null ? image : ""),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$productName",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    editPrice
                                        ? EditProdectPrice(
                                            prise: prise,
                                            productId: productId,
                                            productName: productName,
                                            sellingprice: sellingprice,
                                          )
                                        // Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Container(
                                        //         width: MediaQuery.of(context)
                                        //                 .size
                                        //                 .width /
                                        //             3,
                                        //         child: TextFormField(
                                        //           keyboardType:
                                        //               TextInputType.number,
                                        //           decoration: InputDecoration(
                                        //               prefix:
                                        //                   Text("Edit Price: ")),
                                        //           initialValue: sellingprice,
                                        //           onChanged: (val) {
                                        //             setState(() {
                                        //               editedPrice = val;
                                        //             });
                                        //           },
                                        //         ),
                                        //       ),
                                        //       ElevatedButton(
                                        //         onPressed: () {
                                        //           editReq.productId = productId;
                                        //           editReq.price = sellingprice;
                                        //           ProductPriceEditingApi
                                        //               service =
                                        //               new ProductPriceEditingApi();
                                        //           print(editReq.toJson());
                                        //           print(editReq.toHeader());
                                        //           setState(() {
                                        //             sellingprice = "";
                                        //           });
                                        //         },
                                        //         child: Text("save"),
                                        //         style: ElevatedButton.styleFrom(
                                        //             primary: Colors.black),
                                        //       )
                                        //     ],
                                        //   )
                                        : Text("OFFER : $sellingprice"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    editPrice != true
                                        ? Row(
                                            children: [
                                              Text(
                                                "STOCK : ",
                                                style: TextStyle(
                                                    color:
                                                        quantity.toString() !=
                                                                '0'
                                                            ? Colors.green
                                                            : Colors.red),
                                              ),
                                              Text(
                                                " $quantity  $unit",
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 20, left: 20),
                      width: MediaQuery.of(context).size.width,
                      height: .5,
                      color: Colors.grey,
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                          productName:
                                              productName.toUpperCase(),
                                          mrp: prise,
                                          sellingPrice: sellingprice,
                                          quantity: quantity,
                                          piece: unit,
                                          category: category,
                                          productDetails: productDetails,
                                          subCategory: subCategory,
                                          image: image,
                                          productId: productId,
                                        )),
                              );
                            },
                            child: Text(
                              "Edit product",
                              style: TextStyle(color: Colors.green),
                            )))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class EditProdectPrice extends StatefulWidget {
  EditProdectPrice(
      {Key key,
      this.productName,
      this.sellingprice,
      this.prise,
      this.productId})
      : super(key: key);
  final String productName, prise, sellingprice, productId;
  @override
  _EditProdectPriceState createState() => _EditProdectPriceState();
}

class _EditProdectPriceState extends State<EditProdectPrice> {
  ProductPriceEditingApirequest editReq = new ProductPriceEditingApirequest();
  String editedPrice;
  @override
  void initState() {
    editReq.id = DataStorage.getVendorId();
    editReq.vtoken = DataStorage.getVendorToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(prefix: Text("Edit Price: ")),
            initialValue: widget.sellingprice,
            onChanged: (val) {
              setState(() {
                editedPrice = val;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            editReq.productId = widget.productId;
            editReq.price =
                editedPrice != null ? editedPrice : widget.sellingprice;
            ProductPriceEditingApi service = new ProductPriceEditingApi();
            print(editReq.toJson());
            print(editReq.toHeader());
            print(editReq.productId);
            service.editProductPrice(editReq, context).then((value) => {
                  if (value.data != null)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(value.data),
                      ))
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(value.msg),
                      ))
                    }
                });
          },
          child: Text("save"),
          style: ElevatedButton.styleFrom(primary: Colors.black),
        )
      ],
    );
  }
}
