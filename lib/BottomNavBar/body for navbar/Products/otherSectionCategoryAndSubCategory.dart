import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productAddingPage.dart';

class OtherSectionCategoryAndSubCategory extends StatefulWidget {
  OtherSectionCategoryAndSubCategory({Key key}) : super(key: key);

  @override
  _OtherSectionCategoryAndSubCategoryState createState() =>
      _OtherSectionCategoryAndSubCategoryState();
}

class _OtherSectionCategoryAndSubCategoryState
    extends State<OtherSectionCategoryAndSubCategory> {
  String category, subCategory;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Form(
                key: _formKey,
                              child: ListView(
                  children: [
                    Container(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: false,
                      validator: (val) {
                        if (val.length < 2) {
                          return "Enter the Category Name";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          this.category = val;
                        });
                      },
                      key: Key("121"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " category",
                        hintText: "Category Type",
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 20, top: 20, right: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          this.subCategory=val;
                        });
                      },
                      readOnly: false,
                      // validator: (val) {
                      //   if (val.length < 2) {
                      //     return "Enter the Category Name";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      key: Key("12"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Subcategory",
                        hintText: "Subcategory Type",
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 20, top: 20, right: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // TextFormField()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .8,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAddingPage(
                                      category:category,
                                      subCategoryName: subCategory,
                                    )),
                          );
                        }},
                        child: Text("C O N T I N U E"))),
              )
            ],
          ),
        ));
  }
}
