import 'package:flutter/material.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/action_chip_data.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/action_chips.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/dataFetching/StoreTypeDatafetchingApi.dart';
import 'package:mallu_vendor/dataFetching/storeTypedataModelClass.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../dataStorage.dart';

class StorNameFetchedData extends StatefulWidget {
  StorNameFetchedData(
      {Key key,
      @required this.controller,
      @required this.panelController,
      @required this.vendorToken,
      @required this.vendorId})
      : super(key: key);
  final double spacing = 8;
  final List<ActionChipData> actionChips = ActionChips.all;
  final String vendorToken;
  final String vendorId;
  final ScrollController controller;
  final PanelController panelController;

  @override
  _StorNameFetchedDataState createState() => _StorNameFetchedDataState();
}

class _StorNameFetchedDataState extends State<StorNameFetchedData> {
  StoreTypeDataModelClassReq reqs = StoreTypeDataModelClassReq();
  
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
    final dataProvider = Provider.of<StoreNameAndTypeProvider>(context);
    
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 45),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
            ),
            child: FutureBuilder<StoreTypeDataModelClass>(
                future: StoretypeDataFetching().getStoreType(reqs),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    // return Text(data.data.storetype);
                    return ListView.builder(
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        final usersData = data.data[index].storetype;
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
                                      dataProvider
                                          .changeStoreTypeselection(usersData);
                                          dataProvider.changechekingOtherOrOption(true);
                                          widget.panelController.close();
                                    });
                                  }),
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

        // ActionChip(
        //   backgroundColor: Colors.black,
        //   label: Container(
        //       width: MediaQuery.of(context).size.width / 1.5,
        //       height: 25,
        //       child: Center(
        //           child:
        //               Text("Others", style: TextStyle(color: Colors.white)))),
        //   onPressed: () {
        //     setState(() {
        //       widget.panelController.close();
        //       dataProvider.changeStoreTypeOtherButton(true);
        //       dataProvider.changechekingOtherOrOption(false);
        //       dataProvider.changeStoreTypeselection('Others');
        //       // dataProvider.changePanelControlData(true);
        //       // dataProvider.changeSubCategoryOtherButton(false);
        //     });
        //   },
        //   // avatar: Icon(Icons.select_all),
        // )
      ],
    );
  }
}
