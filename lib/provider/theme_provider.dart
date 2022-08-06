import 'package:bilibili_demo/http/db/hi_cache.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/hi_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;
  var _platformBrightness = SchedulerBinding.instance.window.platformBrightness;

  // 系统dark模式发生变化
  void darkModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance.window.platformBrightness) {
      _platformBrightness = SchedulerBinding.instance.window.platformBrightness;
      notifyListeners();
    }
  }

  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      // 系统dark模式
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(HiConstants.theme, themeMode.value);
    notifyListeners();
  }

  // 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,
      primaryColor: isDarkMode ? HiColor.dark_bg : white,
      // 文字强调色
      accentColor: isDarkMode ? primary[50] : white,
      // tab指示器颜色
      indicatorColor: isDarkMode ? primary[50] : white,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : white,
    );
    return themeData;
  }
}
