import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productAddingPage.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    Color red = Colors.red;
    Color yellow = Colors.yellowAccent;
    Color green = Color(0XFF63E5f9);
    double belowHead = 14;
    double belowbody = 10;
    double midHead = 16;
    double midbody = 14;
    double maxHead = 24;
    double maxbody = 20;

    return Scaffold(
        // appBar: AppBar
        //   brightness: Brightness.dark,
        // ),

        body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return mainWidget(red, maxHead, maxbody);
      } else if (constraints.maxWidth < 300) {
        return mainWidget(yellow, belowHead, belowbody);
      } else {
        return mainWidget(green, midHead, midbody);
      }
    }));
  }

  Widget mainWidget(reds, belowHead, belowbody) => Scaffold(
        body: Container(
          
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                reds,
                Color(0XFF1700FF),
              ])),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top:20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: null,
                    border: Border(
                      bottom: BorderSide(width: 10, color: Colors.white),
                      top: BorderSide(width: 10, color: Colors.white),
                      left: BorderSide(width: 10, color: Colors.white),
                      right: BorderSide(width: 10, color: Colors.white),
                    )),
                child: Center(
                    child: Text(
                  "25%",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: belowHead),
                )),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "STORE IS CREATED ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: belowHead,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Finish following setup to unlock feature ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: belowbody,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
//                        BoxShadow(
//                          blurRadius: 6,
//                          offset: Offset(0, 3),
//                          color: Colors.grey,
//                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      completedSectionLoading(),
                      SizedBox(
                        height: 20,
                      ),
                      sectionWidgets(
                          belowbody: belowbody,
                          belowHead: belowHead,
                          color: Colors.green,
                          subText:
                              "Congratulations on opening your new Online Store!",
                          mainText: "Store created"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                            onPressed: null,
                            child: Text(
                              "Visit store",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      Divider(),
                      sectionWidgets(
                          belowbody: belowbody,
                          belowHead: belowHead,
                          color: Colors.black,
                          mainText: "Add Products",
                          subText: "Add atleast One Product on your store"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProductAddingPage()),
                              // );
                            },
                            child: Text("Add Products")),
                      ),
                      Divider(),
                      sectionWidgets(
                          belowbody: belowbody,
                          belowHead: belowHead,
                          color: Colors.black,
                          mainText: "Add Location",
                          subText:
                              "Add your (Store/place) Location in your online store"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Add Map")),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.maps_ugc_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );

  Widget sectionWidgets(
      {@required belowHead,
      @required belowbody,
      @required color,
      @required String mainText,
      @required String subText}) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText,
            style: TextStyle(
                fontSize: belowHead, fontWeight: FontWeight.w500, color: color),
          ),
          Text(
            subText,
            style: TextStyle(fontSize: belowbody, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget completedSectionLoading() => Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Divider(
                thickness: 2,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                roundShape(),
                roundShapeNoGreenB(),
                roundShapeNoGreenB()
              ],
            ),
          ],
        ),
      );
  Widget roundShape() => Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.green, width: 3),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: 6)
            ]),
        child: Center(
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          ),
        ),
      );
  Widget roundShapeNoGreenB() => Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: 6)
            ]),
      );
}
