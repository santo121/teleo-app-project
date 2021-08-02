import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/productFindedByCatAndSubCatSection.dart';
import 'package:mallu_vendor/dataFetching/addedSubCategoryModelClass.dart';
import 'package:mallu_vendor/dataFetching/addedSubCategorysFetchingApi.dart';

import '../../../../dataStorage.dart';

class SubCategoryListingSection extends StatefulWidget {
  final String categoryName;
  SubCategoryListingSection({Key key, @required this.categoryName})
      : super(key: key);

  @override
  _SubCategoryListingSectionState createState() =>
      _SubCategoryListingSectionState();
}

class _SubCategoryListingSectionState extends State<SubCategoryListingSection> {
  AddedSubCategoryTypeDataModelClassReq reqs =
      new AddedSubCategoryTypeDataModelClassReq();

  @override
  void initState() {
    reqs.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    reqs.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reqs.category = widget.categoryName != null ? widget.categoryName : " ";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        color: Colors.grey[200],
        child: categoryScreen(category: widget.categoryName),
      ),
    );
  }

  Widget categoryScreen({String category}) => GestureDetector(
        
        child: FutureBuilder<AddedSubCategoryModelClass>(
            future: AddedSubCategorysFetchingApi().getAddedSubCategory(reqs),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                // return Text(data.data.storetype);
                return ListView.builder(
                  // controller: widget.scrollController,
                  // controller: widget.scrollController,
                  itemCount: data.subcategory.length,
                  itemBuilder: (context, index) {
                    final usersData = data.subcategory[index].subcategory;
                    return subcategoryScreen(subCategory: usersData.toString());
                  },
                );
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            }),
      );

  Widget subcategoryScreen({String subCategory}) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFindedByCatAndSubCatSection(
                      category: widget.categoryName,
                      subCategory: subCategory,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Center(child: Text(subCategory)),
        ),
      );
}
