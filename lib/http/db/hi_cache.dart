// 缓存管理类
import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  HiCache._();
  SharedPreferences? prefs;
  static HiCache? _instance;
  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
      _instance?.init();
    }
    return _instance!;
  }

  static Future<HiCache>? preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      HiCache.getInstance().prefs = prefs;
      // _instance = HiCache._pre(prefs);
    }
    print(_instance?.prefs);
    return _instance!;
  }

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  T get<T>(String key) {
    var object = prefs?.get(key);
    return object as T;
  }
}
