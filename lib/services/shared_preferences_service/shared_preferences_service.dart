import 'package:injectable/injectable.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_repository.dart';

@injectable
class SharedPreferencesService {
  final ISharedPreferencesRepository _repository;

  SharedPreferencesService(this._repository);

  Future<void> init() => _repository.init();
  Set<String> getKeys() => _repository.getKeys();
  int getInt(String key, [int defValue = 0])=> _repository.getInt(key, defValue);
  bool getBool(String key, [bool defValue = false])=> _repository.getBool(key, defValue);
  double getDouble(String key, [double defValue = .0])=> _repository.getDouble(key, defValue);
  String getString(String key, [String defValue = ''])=> _repository.getString(key, defValue);
  List<String> getStringList(String key, [List<String>? defValue])=> _repository.getStringList(key, defValue);
  Future<bool> setBool(String key, bool value)=> _repository.setBool(key, value);
  Future<bool> setInt(String key, int value)=> _repository.setInt(key, value);
  Future<bool> setDouble(String key, double value)=> _repository.setDouble(key, value);
  Future<bool> setString(String key, String value)=> _repository.setString(key, value);
  Future<bool> setStringList(String key, List<String> value)=> _repository.setStringList(key, value);
  Future<bool> remove(String key)=> _repository.remove(key);
  Future<bool> clear()=> _repository.clear();
}