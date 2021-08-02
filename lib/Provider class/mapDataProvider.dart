import 'package:flutter/cupertino.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProviderModel.dart';

class MapDataProvider extends ChangeNotifier
{
  MapDataProviderModel _addressButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _productButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _finshingButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _mapButton = MapDataProviderModel(error: null,value: null);

  MapDataProviderModel get mapLoadingIconValue => _addressButton;
  MapDataProviderModel get productLoadingIconValue => _productButton;
  MapDataProviderModel get finshingButton => _finshingButton;
  MapDataProviderModel get mapButton => _mapButton;

  void changeMapLoadingIconValue(bool val)
  {
    _addressButton = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changeProductLoadingIconValue(bool val)
  {
    _productButton = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changefinshingButton(bool val)
  {
    _finshingButton= MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  void changemapButton(bool val)
  {
    _mapButton= MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }

}
