import 'package:flutter/material.dart';
import 'package:mallu_vendor/Provider%20class/mapDataProviderModel.dart';

class ProductNameAndCategoryTypeProvider extends ChangeNotifier
{
  MapDataProviderModel _categoryOtherButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _categoryTypeselection = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _panelControlData = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _subCategoryOtherButton = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _subCategoryTypeselection = MapDataProviderModel(error: null,value: null);
  MapDataProviderModel _finalCategory = MapDataProviderModel(error: null,value: null);

  MapDataProviderModel get categoryOtherButton => _categoryOtherButton;
  MapDataProviderModel get categoryTypeselection => _categoryTypeselection;
  MapDataProviderModel get subCategoryOtherButton => _subCategoryOtherButton;
  MapDataProviderModel get subCategoryTypeselection => _subCategoryTypeselection;
  MapDataProviderModel get panelControlData =>_panelControlData;
  MapDataProviderModel get finalCategory =>_finalCategory;

  void changeCategoryOtherButton(bool val)
  {
    _categoryOtherButton = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  } 
  
  
  void changefinalCategory(String val)
  {
    _finalCategory = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
  
  
  
   void changeCategoryTypeselection(String val)
  {
    _categoryTypeselection = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }

  void changePanelControlData(bool val)
  {
    _panelControlData = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }

  void changeSubCategoryOtherButton(bool val)
  {
    _subCategoryOtherButton = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }
   void changeSubCategoryTypeselection(String val)
  {
    _subCategoryTypeselection = MapDataProviderModel(error: null,value: val);
    notifyListeners();
  }

}