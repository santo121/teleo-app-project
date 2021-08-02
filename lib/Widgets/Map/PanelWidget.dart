import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mallu_vendor/BottomNavBar/BottomNavBar.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Store%20Name%20AND%20Type/storeNameAndtypeProvider.dart';
import 'package:mallu_vendor/Widgets/Map/latlongProvider.dart';
import 'package:mallu_vendor/Widgets/Map/mapServices.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final LatLng latLng;
  final String vendorToken;
  final String vendorId;
  String address;
  String streetName;
  String landMark;

  PanelWidget(
      {Key key,
      @required this.controller,
      @required this.panelController,
      @required this.latLng,
      @required this.vendorId,
      @required this.vendorToken});
  MapServicesRiquest request = new MapServicesRiquest();

  @override
  Widget build(BuildContext context) {
    final mapDataProvider = Provider.of<MapDataProvider>(context);
    final dataProvider = Provider.of<StoreNameAndTypeProvider>(context);
    final addressProvider = Provider.of<LatlongProvider>(context);
    // mapDataProvider.changeMapLoadingIconValue(false);
    bool val = mapDataProvider.mapButton.value!=null?mapDataProvider.mapButton.value:false;
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            controller: controller,
            padding: EdgeInsets.zero,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      automaticButton(context),
                      SizedBox(
                        height: 10,
                      ),
                      textFields(context, mapDataProvider, addressProvider),
                    ],
                  )),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  onPressed: latLng != null
                      ? val?null:() {
                          mapDataProvider.changeMapLoadingIconValue(true);
                          mapDataProvider.changemapButton(true);
                          request.vendorToken = this.vendorToken;
                          // dataProvider.vendorToken.value.toString();
                          request.vendorId = this.vendorId;
                          // dataProvider.id.value.toString();
                          request.latitude = latLng.latitude.toString();
                          request.longitude = latLng.longitude.toString();
                          request.address =
                              addressProvider.address.value.toString();
                          request.landmark =
                              addressProvider.landMark.value.toString();
                          request.streetname =
                              addressProvider.streetName.value.toString();
                          print(request.toJson());
                          MapServices services = new MapServices();

                          services.uploadLatLong(request).then((value) => {
                                if (value.msg != null)
                                  {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(content: Text(value.msg))),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNavBar(sections: 0)),
                                    ),
                                    mapDataProvider.changemapButton(false)
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(value.error))),
                                  }
                              });
                          print(this.streetName);
                          print(request.toJson());
                          print(request.toHeader());

                          //          Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => BottomNavBar()),
                          // );
                        }
                      : null,
                  child: latLng != null
                      ?val?  CircularProgressIndicator(): Text(
                          "SAVE THE ADDRESS",
                          style: TextStyle(fontSize: 16),
                        )
                      :Container()))
        ],
      ),
    );
  }

  Widget automaticButton(context) => GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .04,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Container(
              width: 45,
              height: 8,
//  margin:EdgeInsets.only(bottom: 60),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        onTap: automaticButtonTaped,
      );
  void automaticButtonTaped() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
  Widget textFields(context, mapDataProvider, addressProvider) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Address details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key("1"),
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Complete Address"),
              onChanged: (val) {
                this.address = val;
                addressProvider.changeaddress(val);
                // request.address =address!=null? this.address:"null";
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key("2"),
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Street Name"),
              onChanged: (val) {
                this.streetName = val;
                addressProvider.changestreetName(val);
                // request.streetname =streetName!=null? this.streetName:"null";
                print(streetName);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key("3"),
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Land Mark"),
              onChanged: (val) {
                this.landMark = val;
                addressProvider.changelandMark(val);
                // request.landmark = this.landMark!=null? this.landMark:"null";
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                latLng != null
                    ? "Location selected"
                    : "Tap on the map to get marker for set your location",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,color:latLng != null
                    ? Colors.green:Colors.red),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(top: 100),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      mapDataProvider.changeMapLoadingIconValue(true);

                      //          Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => BottomNavBar()),
                      // );
                    },
                    child: Text(
                      "SAVE THE ADDRESS",
                      style: TextStyle(fontSize: 16),
                    )))
          ],
        ),
      );
}
