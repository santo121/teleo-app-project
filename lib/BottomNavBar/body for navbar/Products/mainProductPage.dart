import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/categoryListingSection.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/productLisingSection.dart';

class MainProductPage extends StatefulWidget {
  MainProductPage({Key key}) : super(key: key);

  @override
  _MainProductPageState createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  bool pressedVal = true;
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Products"),
            leading: Container(),
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "All Products",
                  icon: Icon(Icons.format_align_left_sharp),
                ),
                Tab(
                    text: "Categories",
                    icon: Icon(
                      Icons.category_rounded,
                    )),
              ],
            ),
          ),
          body: TabBarView(
            children: [ProductListingSection(), CategoryListing()],
          )

          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(color: Colors.grey[200]),
          //   child: Column(
          //     children: [
          //       Container(
          //         width: MediaQuery.of(context).size.width,
          //         decoration: BoxDecoration(
          //           color: Colors.blue
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             GestureDetector(
          //               onTap: (){
          //                 setState(() {
          //                   pressedVal=true;
          //                 });
          //               },
          //               child: Container(
          //                 width: MediaQuery.of(context).size.width*.4,
          //                 child: Center(
          //                   child: Text(
          //                     "All Products",
          //                     style: TextStyle(color:Colors.white, fontSize:pressedVal?18:16,fontWeight:pressedVal?FontWeight.w600:FontWeight.w300),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               height: 40,
          //               width: .5,
          //               color: Colors.white,
          //             ),
          //             GestureDetector(
          //               onTap: (){
          //                 setState(() {
          //                   pressedVal=false;
          //                 });
          //               },
          //               child: Container(
          //                 width: MediaQuery.of(context).size.width*.4,

          //                 child: Center(
          //                   child: Text(
          //                     "Categories",
          //                     style: TextStyle(color: Colors.white, fontSize:pressedVal?16:18,fontWeight:pressedVal?FontWeight.w300:FontWeight.w600),
          //                   ),
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),

          //       Expanded(
          //           child:pressedVal?:)
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
