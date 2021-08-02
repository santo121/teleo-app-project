
import 'package:flutter/material.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProviderModel.dart';

class StoreNameAndTypeProvider extends ChangeNotifier
{
  MapDataProviderModel _storeTypeOtherButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _storeTypeselection = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _vendorToken = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _id = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _chekingOtherOrOption = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _shopeOpenStatus = MapDataProviderModel(error: null,value: null);

  MapDataProviderModel get storeTypeOtherButton => _storeTypeOtherButton;
  MapDataProviderModel get storeTypeselection => _storeTypeselection;
  MapDataProviderModel get vendorToken => _vendorToken;
  MapDataProviderModel get id => _id;
  MapDataProviderModel get chekingOtherOrOption => _chekingOtherOrOption;
  MapDataProviderModel get shopeOpenStatus => _shopeOpenStatus;

  void changeStoreTypeOtherButton(bool val)
  {
    _storeTypeOtherButton = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changechekingOtherOrOption(bool val)
  {
    _chekingOtherOrOption = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
   void changeStoreTypeselection(String val)
  {
    _storeTypeselection = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  
   void changevendorToken(String val)
  {
    _vendorToken = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  
   void changeid(String val)
  {
    _id = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
   void changeShopeOpenStatus(bool val)
  {
    _shopeOpenStatus= MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }

}