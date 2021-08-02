import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productAddingPage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productNameAndCategoryType.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/subCategorypanel.dart';
import 'package:mallu_vendor/dataFetching/subCategoryDataFetching.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SubCategorySelection extends StatefulWidget {
  SubCategorySelection({Key key, this.category}) : super(key: key);
  final String category;

  @override
  _SubCategorySelectionState createState() => _SubCategorySelectionState();
}

class _SubCategorySelectionState extends State<SubCategorySelection> {
  static const double fabHeightClosed = 10;
  double fabHeight = fabHeightClosed;
  final _formKey = GlobalKey<FormState>();
  final controllerforText = TextEditingController();
  final panelController = PanelController();
  String type = '';
  bool buttonKeyBord = true;
  String subCategotyType = "";

  @override
  void initState() {
    super.initState();
    buttonKeyBord = true;
  }

  @override
  void dispose() {
    controllerforText.dispose();
    buttonKeyBord = true;
    super.dispose();
  }

  SubCategoryTypeDataModelClassReq reqs =
      new SubCategoryTypeDataModelClassReq();

  @override
  Widget build(BuildContext context) {
    final openHeight = MediaQuery.of(context).size.height * .4;
    final clossHeight = MediaQuery.of(context).size.height * .001;
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);

    setState(() {
//hear we get the bool val to find the 'other button is clicked or not'

      buttonKeyBord = dataProvider.subCategoryOtherButton.value != null
          ? dataProvider.subCategoryOtherButton.value
          : true;

      subCategotyType = dataProvider.subCategoryTypeselection.value != null
          ? dataProvider.subCategoryTypeselection.value
          : null;

      if (buttonKeyBord == true) {
        setState(() {
          controllerforText.clear();
          subCategotyType = dataProvider.subCategoryTypeselection.value;
        });
      } else if (buttonKeyBord == false) {
        final type = controllerforText.text;
        // final subCategorytypes = subCategoryController.text;
        setState(() {
          subCategotyType = type;
          // subCategoryType = subCategorytypes;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Sub Category"),
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            controller: panelController,
            minHeight: clossHeight,
            maxHeight: openHeight,
            parallaxEnabled: true,
            parallaxOffset: .05,
            onPanelSlide: (value) => setState(() {
              final panelMaxScroll = openHeight - clossHeight;
              fabHeight = value * panelMaxScroll;
            }),
            body: mainScreen(context, panelController, dataProvider),
            panelBuilder: (controller) => SubCategoryPanel(
              categoryType: widget.category,
              scrollController: controller,
              panelController: panelController,
            ),
          ),
          
          Positioned(
            bottom: fabHeight,
            left: 20,
            right: 20,
            child: productInputbutton(context),
          ),
        ],
      ),
    );
  }

  Widget mainScreen(context, panelController, dataProvider) => GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (val) {
                          if (val.length < 2) {
                            return "Enter the Product name";
                          } else {
                            return null;
                          }
                        },
                        controller: controllerforText,
                        onChanged: (val) {
                          setState(() {
                            this.type = val;
                          });
                        },
                        readOnly: buttonKeyBord,
                        key: Key("3"),
                        keyboardType: TextInputType.emailAddress,
                        onTap: () {
                          if (panelController.isPanelOpen) {
                            panelController.close();
                            setState(() {
                              this.buttonKeyBord = true;
                              dataProvider.changeSubCategoryOtherButton(true);
                            });
                          } else {
                            panelController.open();
                            setState(() {
                              this.buttonKeyBord = true;
                              dataProvider.changeSubCategoryOtherButton(true);
                            });
                          }
                          setState(() {
                            reqs.category = this.type != null ? type : "";
                            // this.categorySection = true;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Choose subcategory",
                          hintText: subCategotyType != null
                              ? subCategotyType
                              : "Subcategory Type",
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 20, top: 20, right: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    buttonKeyBord?Container():skipButton(),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      );

  Widget productInputbutton(
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductAddingPage(
                              category: widget.category,
                              subCategoryName: subCategotyType,
                              // productName: productName,
                            )),
                  );
                }},
                child: Text("C O N T I N U E"))),
      );

      Widget skipButton()=> TextButton(onPressed: (){
Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductAddingPage(
                              category: widget.category,
                              
                              // productName: productName,
                            )),
                  );

      }, child:Text("S K I P"));
}
