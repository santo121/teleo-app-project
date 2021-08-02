import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/Sections/subCategoryListingSection.dart';
import 'package:mallu_vendor/dataFetching/ProductFetchingModelClass.dart';
import 'package:mallu_vendor/dataFetching/addedCategorysFetchingApi.dart';
import 'package:mallu_vendor/dataFetching/addedCategorysModelClass.dart';
import 'package:mallu_vendor/dataFetching/productfetchingApi.dart';
import 'package:mallu_vendor/dataStorage.dart';

class CategoryListing extends StatefulWidget {
  CategoryListing({Key key}) : super(key: key);

  @override
  _CategoryListingState createState() => _CategoryListingState();
}

class _CategoryListingState extends State<CategoryListing> {
  AddedCategoryTypeDataModelClassReq reqs =
      new AddedCategoryTypeDataModelClassReq();
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.blue,
          padding: EdgeInsets.only(bottom: 60),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: FutureBuilder<AddedCategoryModelClass>(
                future: AddCategorysFetchingApi().getAddedCategory(reqs,context),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    if (data.category.length == 0) {
                return DontaddanyCategory();
              }else{
                    return ListView.builder(
                      itemCount: data.category.length,
                      itemBuilder: (context, index) {
                        final usersData = data.category[index].category;
                        // ActionChip(label: Text(usersData.data[index]["productname"]), onPressed:(){},avatar: Icon(Icons.select_all),);
                        return categoryScreen(category: usersData);
                      },
                    );}

                  } else {
                    return Center(
                        child: const CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
                  }
                },
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: SizedBox(
        //       width: MediaQuery.of(context).size.width * .9,
        //       height: 50,
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(primary: Colors.black),
        //           onPressed: () {},
        //           child: Text(
        //             "Add new Category",
        //             style: TextStyle(fontSize: 20),
        //           ))),
        // )
      ],
    );
  }

  Widget categoryScreen({String category}) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategoryListingSection(categoryName: category,)),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Center(child: Text(category)),
        ),
      );
}

class DontaddanyCategory extends StatelessWidget {
  const DontaddanyCategory({Key key}) : super(key: key);

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
