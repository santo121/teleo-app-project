import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static SharedPreferences _preferences;
  static const _keyVendorToken = 'vendorToken';
  static const _keyVendorId = 'vendorId';
  static const _firstProcess = 'firstProduct';
  static const _storeName = 'StoreNameFinish';
  static const _ownerName = 'ownerName';
  static const _altphonenumber = 'altphonenumber';
  static const _email = 'email';
  static const _address = 'address';
  static const _city = 'city';
  static const _state = 'state';
  static const _postalcode = 'postacode';
  static const _country = 'country';
  static const _gstnumber = 'gstnumber';
  static const _fassai = 'fassai';
  static const _imageurl = 'iamgeurl';
  static const _shopStatus = 'shopStatus';
  static const _pickFromStore = 'pickFromStore';
  static const _homeDelivery = 'homeDelivery';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setownerName({String ownerName}) async =>
      await _preferences.setString(_ownerName, ownerName);
  static String getownerName() => _preferences.getString(_ownerName);

  static Future setaltphonenumber({String altphonenumber}) async =>
      await _preferences.setString(_altphonenumber, altphonenumber);
  static String getaltphonenumber() => _preferences.getString(_altphonenumber);

  static Future setemail({String email}) async =>
      await _preferences.setString(_email, email);
  static String getemail() => _preferences.getString(_email);

  static Future setaddress({String address}) async =>
      await _preferences.setString(_address, address);
  static String getaddress() => _preferences.getString(_address);

  static Future setcity({String city}) async =>
      await _preferences.setString(_city, city);
  static String getcity() => _preferences.getString(_city);

  static Future setstate({String state}) async =>
      await _preferences.setString(_state, state);
  static String getstate() => _preferences.getString(_state);

  static Future setpostalcode({String postalcode}) async =>
      await _preferences.setString(_postalcode, postalcode);
  static String getpostalcode() => _preferences.getString(_postalcode);

  static Future setcountry({String country}) async =>
      await _preferences.setString(_country, country);
  static String getcountry() => _preferences.getString(_country);

  static Future setgstnumber({String gstnumber}) async =>
      await _preferences.setString(_gstnumber, gstnumber);
  static String getgstnumber() => _preferences.getString(_gstnumber);

  static Future setfassai({String fassai}) async =>
      await _preferences.setString(_fassai, fassai);
  static String getfassai() => _preferences.getString(_fassai);

  static Future setimageurl({String imageurl}) async =>
      await _preferences.setString(_imageurl, imageurl);
  static String getimageurl() => _preferences.getString(_imageurl);

  static Future setshopStatus({bool shopStatus}) async =>
      await _preferences.setBool(_shopStatus, shopStatus);
  static bool getShopStatus() => _preferences.getBool(_shopStatus);

  static Future setpickFromStore({bool pickFromStore}) async =>
      await _preferences.setBool(_pickFromStore, pickFromStore);
  static bool getpickFromStore() => _preferences.getBool(_pickFromStore);





  static Future sethomeDelivery({bool homeDelivery}) async =>
      await _preferences.setBool(_homeDelivery, homeDelivery);
  static bool gethomeDelivery() => _preferences.getBool(_homeDelivery);



  

  static Future setVendorToken({String vendorToken}) async =>
      await _preferences.setString(_keyVendorToken, vendorToken);
  static String getVendorToken() => _preferences.getString(_keyVendorToken);

  static Future setVendorId({String vendorId}) async =>
      await _preferences.setString(_keyVendorId, vendorId);
  static String getVendorId() => _preferences.getString(_keyVendorId);

  static Future setfirstProduct({bool value}) async =>
      await _preferences.setBool(_firstProcess, value);
  static bool getfirstProduct() => _preferences.getBool(_firstProcess);

  static Future setstoreName({String value}) async =>
      await _preferences.setString(_storeName, value);
  static String getstoreName() => _preferences.getString(_storeName);
}
