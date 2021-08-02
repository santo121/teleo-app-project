import 'package:flutter/material.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProviderModel.dart';

class VTokenProvider extends ChangeNotifier
{
  MapDataProviderModel _vendorToken = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _vendorId = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _deliverySwitchOne = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _deliverySwitchTwo = MapDataProviderModel(error: null,value: null);

  MapDataProviderModel get vendorToken => _vendorToken;
  MapDataProviderModel get vendorId=> _vendorId; 
  MapDataProviderModel get deliverySwitchOne=> _deliverySwitchOne; 
  MapDataProviderModel get deliverySwitchTwo=> _deliverySwitchTwo; 
  

  void changeVendorToken(String val)
  {
    _vendorToken = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changeVendorId(String val)
  {
    _vendorId = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changeDeliverySwitchOne(bool val)
  {
    _deliverySwitchOne = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changeDeliverySwitchTwo(bool val)
  {
    _deliverySwitchTwo = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  

}
