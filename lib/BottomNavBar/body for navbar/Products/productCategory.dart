import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/CategoryPanel.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/otherSectionCategoryAndSubCategory.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productNameAndCategoryType.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/subCategorySelection.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/dataFetching/subCategoryDataFetching.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductCategory extends StatefulWidget {
  ProductCategory({Key key, @required this.shoptypeOther}) : super(key: key);
  final bool shoptypeOther;

  @override
  _ProductCategoruState createState() => _ProductCategoruState();
}

class _ProductCategoruState extends State<ProductCategory> {
  // bool categorySection = true;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final subCategoryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    // print('Second text field: ${myController.text}');
  }

  @override
  void dispose() {
    myController.dispose();
    subCategoryController.dispose();
    buttonKeyBord = true;
    super.dispose();
  }

  static const double fabHeightClosed = 10;
  double fabHeight = fabHeightClosed;
  final panelController = PanelController();
  bool buttonKeyBord = true;
  // bool subcategoryKeybord = true;
  String categotyType = "";
  // String subCategoryType = "";
  String categotyTypevlaueChecking = "";
  String productName = "";
  String type = "";
  bool storeType = true;
  SubCategoryTypeDataModelClassReq reqs =
      new SubCategoryTypeDataModelClassReq();

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);
    final storTypeProvider = Provider.of<StoreNameAndTypeProvider>(context);
    setState(() {
//hear we get the bool val to find the 'other button is clicked or not'

      buttonKeyBord = dataProvider.categoryOtherButton.value != null
          ? dataProvider.categoryOtherButton.value
          : true;

//111111111

      categotyType = dataProvider.categoryTypeselection.value != null
          ? dataProvider.categoryTypeselection.value
          : null;

      if (buttonKeyBord == true) {
        setState(() {
          myController.clear();
          subCategoryController.clear();
          categotyType = dataProvider.categoryTypeselection.value;
          // subCategoryType =dataProvider.subCategoryTypeselection.value;
          // categotyTypevlaueChecking = dataProvider.categoryTypeselection.value;
          reqs.category = dataProvider.categoryTypeselection.value != null
              ? dataProvider.categoryTypeselection.value
              : "";
        });
      } else if (buttonKeyBord == false) {
        // subcategoryKeybord = false;
        final type = myController.text;
        // final subCategorytypes = subCategoryController.text;
        setState(() {
          categotyType = type;
          // subCategoryType = subCategorytypes;
        });
      }
    });
    final openHeight = MediaQuery.of(context).size.height * .4;
    final clossHeight = MediaQuery.of(context).size.height * .001;
    storeType = storTypeProvider.chekingOtherOrOption.value!=null?storTypeProvider.chekingOtherOrOption.value:true;

    return storeType
        ? Scaffold(
            appBar: AppBar(
              title:  Text("Add Category"),
              
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
                  panelBuilder: (controller) => CategoryNameFetchedData(
                    scrollController: controller,
                    panelController: panelController,
                  ),
                  // : SubCategoryPanel(
                  //     catecoryType: this.categotyType,
                  //     panelController: panelController,
                  //     scrollController: controller,
                  //   ),
                ),
                Positioned(
                  bottom: fabHeight,
                  left: 20,
                  right: 20,
                  child: productInputbutton(context),
                ),
              ],
            ))
        : OtherSectionCategoryAndSubCategory();
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
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    categoryNameInputField(dataProvider),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget categoryNameInputField(dataProvider) => TextFormField(
        validator: (val) {
          if (val.length < 2) {
            return "Enter the Product name";
          } else {
            return null;
          }
        },
        controller: myController,
        onChanged: (val) {
          setState(() {
            this.type = val;
          });
        },
        // obscuringCharacter: shopType==null?"sa":"ds",

        readOnly: buttonKeyBord,
        key: Key("3"),
        keyboardType: TextInputType.emailAddress,
        onTap: () {
          setState(() {
            reqs.category = this.type != null ? type : "";
            // this.categorySection = true;
          });
          if (panelController.isPanelOpen) {
            panelController.close();
            setState(() {
              this.buttonKeyBord = true;
              dataProvider.changeCategoryOtherButton(true);
            });
          } else {
            panelController.open();
            this.buttonKeyBord = true;
            dataProvider.changeCategoryOtherButton(true);
          }
        },
        decoration: InputDecoration(
          labelText: "Choose your category",
          hintText: categotyType != null ? categotyType : "Category Type",
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  Widget productInputbutton(context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
            height: 50,
            child: categotyType != null
                ? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(categotyType);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubCategorySelection(
                                    category: categotyType,
                                  )),
                        );
                      }
                    },
                    child: Text("C O N T I N U E"))
                : null),
      );

  void automaticButtonTaped() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();

      this.buttonKeyBord = true;
    }
  }

  void closeAutomaticButtonTaped() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.close();
}
