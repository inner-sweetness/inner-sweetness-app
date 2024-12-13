import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ISharedPreferencesRepository)
class SharedPreferencesRepository implements ISharedPreferencesRepository {
  SharedPreferences? _sharedPreferences;

  @override
  Future<SharedPreferences> init() async => _sharedPreferences ??= await SharedPreferences.getInstance();

  @override
  Future<bool> clear() => _sharedPreferences!.clear();

  @override
  bool getBool(String key, [bool defValue = false]) => _sharedPreferences!.getBool(key) ?? defValue;

  @override
  double getDouble(String key, [double defValue = .0]) => _sharedPreferences!.getDouble(key) ?? defValue;

  @override
  int getInt(String key, [int defValue = 0]) => _sharedPreferences!.getInt(key) ?? defValue;

  @override
  Set<String> getKeys() => _sharedPreferences!.getKeys();

  @override
  String getString(String key, [String defValue = '']) => _sharedPreferences!.getString(key) ?? defValue;

  @override
  List<String> getStringList(String key, [List<String>? defValue]) => _sharedPreferences!.getStringList(key) ?? defValue ?? <String>[];

  @override
  Future<bool> remove(String key) => _sharedPreferences!.remove(key);

  @override
  Future<bool> setBool(String key, bool value) => _sharedPreferences!.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) => _sharedPreferences!.setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) => _sharedPreferences!.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) => _sharedPreferences!.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) => _sharedPreferences!.setStringList(key, value);
}

abstract class ISharedPreferencesRepository {
  Future<void> init();
  Set<String> getKeys();
  int getInt(String key, [int defValue = 0]);
  bool getBool(String key, [bool defValue = false]);
  double getDouble(String key, [double defValue = .0]);
  String getString(String key, [String defValue = '']);
  List<String> getStringList(String key, [List<String>? defValue]);
  Future<bool> setBool(String key, bool value);
  Future<bool> setInt(String key, int value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> value);
  Future<bool> remove(String key);
  Future<bool> clear();
}
