import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/productDetailsPage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productCategory.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/dataFetching/ProductFetchingModelClass.dart';
import 'package:mallu_vendor/dataFetching/productfetchingApi.dart';
import 'package:provider/provider.dart';
import '../../../../dataStorage.dart';
import 'package:flutter_share/flutter_share.dart';

class ProductListingSection extends StatefulWidget {
  ProductListingSection({Key key}) : super(key: key);

  @override
  _ProductListingSectionState createState() => _ProductListingSectionState();
}

class _ProductListingSectionState extends State<ProductListingSection> {
  ProductTypeDataModelClassReq reqs = new ProductTypeDataModelClassReq();
  bool addProductButton;
  bool updationFinishButton =false; 
  bool finishButtonResponse = false;
  @override
  void initState() {
    reqs.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    reqs.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;
    super.initState();
    updationFinishButton = DataStorage.getfirstProduct()==true?DataStorage.getfirstProduct():false;
  }

  @override
  Widget build(BuildContext context) {
    final storTypeProvider = Provider.of<StoreNameAndTypeProvider>(context);
    final mapDataProvider = Provider.of<MapDataProvider>(context);
    var finish = mapDataProvider.finshingButton;
    finish.value!=null?
     this.finishButtonResponse = finish.value
          : this.finishButtonResponse = false;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.blue,
          padding: EdgeInsets.only(bottom: 60),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: FutureBuilder<ProductFetchingModelClass>(
                future: ProducttypeDataFetching().getStoreType(reqs, context),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                   if (data.data.length == 0) {
                return DontaddanyProducts();
              }else{
                    return ListView.builder(
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        final usersData = data;
                        // ActionChip(label: Text(usersData.data[index]["productname"]), onPressed:(){},avatar: Icon(Icons.select_all),);
                        return productContainer(
                            productName:
                                usersData.data[index].productname.toUpperCase(),
                            prise: usersData.data[index].mrp.toString(),
                            quantity: usersData.data[index].quantity.toString(),
                            sellingprice:
                                usersData.data[index].sellingprice.toString(),
                            unit: usersData.data[index].unit,
                            category: usersData.data[index].category,
                            productDetails: usersData.data[index].description,
                            subCategory: usersData.data[index].subcategory,
                            image: usersData.data[index].imagelocation,
                            productId: usersData.data[index].productid);
                      },
                    );}
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
                  }
                },
              ),
            ),
          ),
        ),
         
         finishButtonResponse? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, shape: StadiumBorder()),
                  onPressed: () {
                    setState(() {
                      storTypeProvider.changechekingOtherOrOption(true);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategory(
                                shoptypeOther: true,
                              )),
                    );
                  },
                  child: Text(
                    "Add New Product",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))),
        ):updationFinishButton?
         Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, shape: StadiumBorder()),
                  onPressed: () {
                    setState(() {
                      storTypeProvider.changechekingOtherOrOption(true);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategory(
                                shoptypeOther: true,
                              )),
                    );
                  },
                  child: Text(
                    "Add New Product",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))),
        ): Container()
      ],
    );
  }

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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                      productName: productName.toUpperCase(),
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
                              width: 70,
                              height: 70,
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
                                margin: EdgeInsets.only(top: 5, bottom: 5),
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
                                    Text("OFFER : ₹$sellingprice"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "STOCK : ",
                                          style: TextStyle(
                                              color: quantity.toString() != '0'
                                                  ? Colors.green
                                                  : Colors.red),
                                        ),
                                        Text(
                                          " $quantity  $unit",
                                        ),
                                      ],
                                    ),
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
                               share(productid:productId,title: productName);
                            },
                            child: Text(
                              "Share",
                              style: TextStyle(color: Colors.green),
                            )))
                  ],
                ),
              ),
            ),
          ],
        ),
      );

      Future<void> share({String productid,String title}) async {
        String vendorid = DataStorage.getVendorId();
    await FlutterShare.share(
        title: "Mallu vendor",
        text: title,
        linkUrl: "https://teleo-online.com/product/$vendorid/$productid",
        chooserTitle: 'Where you want to share ?');
  }
}

class DontaddanyProducts extends StatelessWidget {
  const DontaddanyProducts({Key key}) : super(key: key);

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
              Text("You don't Add any Products",style: TextStyle(color: Colors.white,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}