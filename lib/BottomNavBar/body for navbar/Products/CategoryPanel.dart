import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/categorynameList.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productNameAndCategoryType.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/subCategorySelection.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/action_chip_data.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/dataFetching/categoryDataModelClass.dart';
import 'package:mallu_vendor/dataFetching/categoryFetchingApi.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../dataStorage.dart';

class CategoryPanel extends StatelessWidget {
  final PanelController panelController;
  final ScrollController scrollController;
  CategoryPanel(
      {Key key,
      @required this.panelController,
      @required this.scrollController})
      : super(key: key);

  final double spacing = 8;
  final List<ActionChipData> actionChips = CategoryNameList.all;
  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);
        
    return ListView(
      children: [
        Center(child: categoryTypes(context, dataProvider)),
// Center(child: othersButton(context,dataProvider))
      ],
      controller: scrollController,
    );
  }

  Widget categoryTypes(context, dataProvider) => Center(
        child: Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: actionChips
              .map((actionChip) => ActionChip(
                  backgroundColor: Colors.grey[200],
                  label: Text(actionChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // dataProvider.storeTypeOtherButton.value=false;
                    dataProvider.changeCategoryTypeselection(
                        actionChip.label.toString());
                  }))
              .toList(),
        ),
      );
  Widget othersButton(context, dataProvider) => SizedBox(
        child: ElevatedButton(
          onPressed: () {
            panelController.isPanelOpen
                ? panelController.close()
                : panelController.open();
            dataProvider.changeCategoryOtherButton(false);
          },
          child: Text(
            "others",
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
        ),
      );
}

class CategoryNameFetchedData extends StatefulWidget {
  CategoryNameFetchedData({
    Key key,
    @required this.scrollController,
    @required this.panelController,
  }) : super(key: key);
  final double spacing = 8;
  // final List<ActionChipData> actionChips = ActionChips.all;

  final PanelController panelController;
  final ScrollController scrollController;

  @override
  _CategoryNameFetchedDataState createState() => _CategoryNameFetchedDataState();
}

class _CategoryNameFetchedDataState extends State<CategoryNameFetchedData> {
  CategoryTypeDataModelClassReq reqs = CategoryTypeDataModelClassReq();
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
    final storTypeProvider = Provider.of<StoreNameAndTypeProvider>(context);
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 50),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
            ),
            child: FutureBuilder<CategoryDataModelClass>(
                future: CategorytypeDataFetching().getStoreType(reqs),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    // return Text(data.data.storetype);
                    return ListView.builder(
                      controller: widget.scrollController,
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        final usersData = data.data[index].category;
                        return Wrap(
                          children: [
                            Center(
                              child: ActionChip(
                                label: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Center(child: Text(usersData))),
                                onPressed: () {
                                  setState(() {
                                    widget.panelController.close();
                                    dataProvider.changeCategoryTypeselection(
                                        usersData.toString());
                                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubCategorySelection(
                                    category: usersData,
                                    // productName: productName,
                                  )),
                        );
                                  });
                                },
                                // avatar: Icon(Icons.select_all),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                }),
          )),
        ),
        ActionChip(
          backgroundColor: Colors.black,
          label: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 25,
              child: Center(child: Text("Others",style: TextStyle(color: Colors.white)))),
          onPressed: () {
            setState(() {
              widget.panelController.close();
              storTypeProvider.changechekingOtherOrOption(false);
              dataProvider.changePanelControlData(true);
              dataProvider.changeCategoryOtherButton(false);
            });
          },
          // avatar: Icon(Icons.select_all),
        )
      ],
    );
  }
}
