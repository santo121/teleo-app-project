import 'package:flutter/cupertino.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProviderModel.dart';

class LatlongProvider extends ChangeNotifier
{
  
  MapDataProviderModel _address = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _streetName = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _landMark = MapDataProviderModel(error: null,value: null);

  MapDataProviderModel get address => _address;
  MapDataProviderModel get streetName => _streetName;
  MapDataProviderModel get landMark => _landMark;

 
  void changeaddress(String val)
  {
    _address = MapDataProviderModel(error: null,value: val);
   
    notifyListeners();
  }
  void changestreetName(String val)
  {
  
    _streetName = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changelandMark(String val)
  {
    _landMark = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
}
