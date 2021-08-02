import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productCategory.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/home%20page/homePage.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Widgets/Map/Map.dart';
import 'package:provider/provider.dart';
import '../../../dataStorage.dart';

class FirstLoadingPage extends StatefulWidget {
  final String vendorToken,vendorId;
  FirstLoadingPage({this.vendorToken,this.vendorId});
  @override
  _FirstLoadingPageState createState() => _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {

  @override
  void initState() {  
    super.initState();
    updationFinishButton = DataStorage.getfirstProduct()==true?DataStorage.getfirstProduct():false;
    
  }
  bool updationFinishButton =false; 
  bool mapResponse = false;
  bool productResponse = false;
  bool finishButtonResponse = false;
  @override
  Widget build(BuildContext context) {
  
    final mapDataProvider = Provider.of<MapDataProvider>(context);
    
    var mapValue = mapDataProvider.mapLoadingIconValue;
    var productValue = mapDataProvider.productLoadingIconValue;
    var finish = mapDataProvider.finshingButton;
    
    print(productValue.value);
    setState(() {
      mapValue.value != null
          ? this.mapResponse = mapValue.value
          : this.mapResponse = false;
      productValue.value != null
          ? this.productResponse = productValue.value
          : this.productResponse = false;
      finish.value != null
          ? this.finishButtonResponse = finish.value
          : this.finishButtonResponse = false;
    });

    return Scaffold(
        body: finishButtonResponse
            ? HomePage():updationFinishButton?HomePage()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Column(
                  children: [
                    topSection(),
                    Divider(),
                    iamgeContainer(),
                    productResponse
                        ? finishing(finish,mapDataProvider)
                        : mapResponse
                            ? productFloatingButton(context)
                            : mapFloatingButton(context),
                    SizedBox(height: 20),
                    productResponse
                        ? productBackFloatingButton(context)
                        : mapResponse
                            ? mapBackFloatingButton(context)
                            : Container(),
                  ],
                ),
              ));
  }

  Widget topSection() => Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              //this section is for white divider
              height: 2,
              margin: EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width / 1.5,
              color: Colors.white,
            ),
            Container(
              //this section is for oriant the round section
              height: 90,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      roundShapeForSuccess(borders: true),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Created Store",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      roundShapeForSuccess(borders: mapResponse, number: "2"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(mapResponse ? "Map created" : "Map not created",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      roundShapeForSuccess(
                          borders: productResponse, number: "3 "),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .2,
                        child: Text(
                            productResponse ? "Products added" : "Products",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  
                  width: MediaQuery.of(context).size.width / 1.75,
                  child: Center(
                      child: Text(
                    productResponse
                        ? "Your Product Ragistration is successful"
                        : mapResponse
                            ? "Your map Ragistration is successful"
                            : "Congratulation on opening your new online store",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            )
          ],
        ),
      );
  Widget roundShapeForSuccess({@required bool borders, String number}) =>
      Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              color: borders ? Colors.green : Colors.white,
              shape: BoxShape.circle),
          child: borders
              ? Center(
                  child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ))
              : Center(child: Text(number)));

  Widget iamgeContainer() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .4,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                margin: EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: productResponse
                                  ? AssetImage("assets/filledShelf.png")
                                  : mapResponse
                                      ? AssetImage("assets/shelf.png")
                                      : AssetImage(
                                          "assets/loadingBackground.jpeg"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      // child: Image(image: AssetImage("assets/digital.jpg"),),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          productResponse
                              ? "congratulations for your new store"
                              : mapResponse
                                  ? "You need to add at least one product because your shelf is empty"
                                  : 'Finish following setups to unlock feature',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget mapFloatingButton(context) => Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 50,
        child: ElevatedButton(
          child: Text(
            "C O N T I N U E",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          },
          style: ElevatedButton.styleFrom(primary: Colors.white),
        ),
      );
  Widget productFloatingButton(context) => Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 50,
        child: ElevatedButton(
          child: Text(
            "C O N T I N U E",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductCategory(shoptypeOther: true,)),
            );
          },
          style: ElevatedButton.styleFrom(primary: Colors.white),
        ),
      );
  Widget mapBackFloatingButton(context) => GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "change Location",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        },
      );
  Widget productBackFloatingButton(context) => GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add some more products",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductCategory(shoptypeOther: true,)),
          );
        },
      );
  Widget finishing(finish,mapDataProvider) => Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .9,
        child: productResponse
            ? ElevatedButton(
                child: Text(
                  "F I N I S H",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  setState(() async{
                    // finish.value = true;
                    mapDataProvider.changefinshingButton(true);
                        await DataStorage.setfirstProduct(value: true);
                  });
                  
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
              )
            : SizedBox(),
      );
}
