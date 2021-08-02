import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productAddingPage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/productNameAndCategoryType.dart';
import 'package:mallu_vendor/dataFetching/subCategoryDataFetching.dart';
import 'package:mallu_vendor/dataFetching/subCategoryModelClass.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../dataStorage.dart';

class SubCategoryPanel extends StatefulWidget {
  SubCategoryPanel(
      {Key key,
      this.panelController,
      this.scrollController,
      @required this.categoryType})
      : super(key: key);
  final PanelController panelController;
  final ScrollController scrollController;
  final String categoryType;
  final double spacing = 8;
  @override
  _SubCategoryPanelState createState() => _SubCategoryPanelState();
}

class _SubCategoryPanelState extends State<SubCategoryPanel> {
  SubCategoryTypeDataModelClassReq reqs =
      new SubCategoryTypeDataModelClassReq();

  @override
  void initState() {
    // reqs.category=widget.catecoryType;
    // print("1222222222222222222222222222222222222222222222222222222222222${widget.catecoryType}");
    reqs.vendorId =
        DataStorage.getVendorId() != null ? DataStorage.getVendorId() : null;
    reqs.vendorToken = DataStorage.getVendorToken() != null
        ? DataStorage.getVendorToken()
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<ProductNameAndCategoryTypeProvider>(context);

    reqs.category = widget.categoryType != null ? widget.categoryType : " ";
    // widget.catecoryType==null??widget.panelController.close();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 40),
            child: FutureBuilder<SubCategoryModelClass>(
                future: SubCategoryDataFetching().getStoreType(reqs),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    // return Text(data.data.storetype);
                    return ListView.builder(
                      // controller: widget.scrollController,
                      controller: widget.scrollController,
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        final usersData = data.data[index].subcategory;
                        return Wrap(
                          children: [
                            Center(
                              child: ActionChip(
                                label: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Center(child: Text(usersData))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductAddingPage(
                                              category: widget.categoryType,
                                              subCategoryName: usersData,
                                              // productName: productName,
                                            )),
                                  );

                                  setState(() {
                                    widget.panelController.close();
                                    dataProvider.changeSubCategoryTypeselection(
                                        usersData);
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
          ),
        ),
        ActionChip(
          backgroundColor: Colors.black,
          label: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 25,
              child: Center(
                  child:
                      Text("Others", style: TextStyle(color: Colors.white)))),
          onPressed: () {
            setState(() {
              widget.panelController.close();
              dataProvider.changePanelControlData(true);
              dataProvider.changeSubCategoryOtherButton(false);
            });
          },
          // avatar: Icon(Icons.select_all),
        )
      ],
    );
  }
}
