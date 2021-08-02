import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProvider.dart';
import 'package:mallu_vendor/Widgets/Map/PanelWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:mallu_vendor/Widgets/Map/applicationBlock.dart';

import '../../dataStorage.dart';

class MapPage extends StatefulWidget {
  final Function(String name) onChangedName;
  MapPage({Key key, this.onChangedName}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  List<Marker> myMarker = [];
  LatLng tappedPoint;
  bool keyboardEnabel = false;
  final panelController = PanelController();
  String vendorToken="";
  String vendorId="";
  @override
  void initState() {
    vendorToken = DataStorage.getVendorToken()!=null?DataStorage.getVendorToken():null;
    vendorId = DataStorage.getVendorId()!=null?DataStorage.getVendorId():null;
    
    super.initState();
  }

  @override
  void dispose() {
    keyboardEnabel = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final applicationBlock = Provider.of<ApplicationBlock>(context);
    
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "PICK CURRENT SHOP LOCATION",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body:(applicationBlock.currentLocation == null)?
        Center(
              child: CircularProgressIndicator(),
            ):
        SlidingUpPanel(
          controller: panelController,
          body: googleMap(applicationBlock),
          panelBuilder: (controller) => PanelWidget(
            vendorId: this.vendorId,
            vendorToken: this.vendorToken,
            latLng: tappedPoint,
            controller: controller,
            panelController: panelController,
          ),
          minHeight: MediaQuery.of(context).size.height * .2,
          maxHeight: MediaQuery.of(context).size.height * .5,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          parallaxEnabled: true,
          parallaxOffset: .5,
        ));
  }

  Widget googleMap(applicationBlock) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          myLocationEnabled: true,
          onTap: _handleTap,
          initialCameraPosition: CameraPosition(target: LatLng(applicationBlock.currentLocation.latitude, 
          applicationBlock.currentLocation.longitude),
          zoom: 18.0,
          ),

          markers: Set.from(myMarker),
          mapType: MapType.hybrid,
        ),
      );

    void _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(
            tappedPoint.toString(),
          ),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (latlng) {
            print("map$latlng");
            setState(() {
              this.tappedPoint = latlng;
            });
            print("draged point");
          }));
      this.tappedPoint = tappedPoint;
      print(tappedPoint.toString());
    });
  }
}
