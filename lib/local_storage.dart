import 'package:os_basecode/os_basecode.dart';

class LocalStorage {
  SharedPreferences pref;
  LocalStorage(this.pref);

  T? getItem<T>(String key) {
    if (T == String) {
      return pref.getString(key) as T?;
    } else if (T == double) {
      return pref.getDouble(key) as T?;
    } else if (T == int) {
      return pref.getInt(key) as T?;
    } else if (T == bool) {
      return pref.getBool(key) as T?;
    }
    return null;
  }

  setItem<T>(String key, T value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    }
  }

  removeItem(String key) async {
    await pref.remove(key);
  }

  Future<bool> removeAllItem() async {
    return await pref.clear();
  }
}
