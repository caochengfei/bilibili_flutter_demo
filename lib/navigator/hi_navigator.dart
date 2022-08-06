import 'package:bilibili_demo/navigator/tabbar.dart';
import 'package:bilibili_demo/page/dark_mode_page.dart';
import 'package:bilibili_demo/page/home_page.dart';
import 'package:bilibili_demo/page/login_page.dart';
import 'package:bilibili_demo/page/regis_page.dart';
import 'package:bilibili_demo/page/video_detail_page.dart';
import 'package:flutter/material.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? prev);

// 创建路由页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

// 获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == status) {
      return i;
    }
  }
  return -1;
}

// 路由状态枚举
enum RouteStatus { login, regis, home, detail, unknow, darkMode }

// 获得路由状态
RouteStatus getStatus(MaterialPage page) {
  if (page.child is CFLoginPage) {
    return RouteStatus.login;
  } else if (page.child is CFRegisPage) {
    return RouteStatus.regis;
  } else if (page.child is CFTabBar) {
    return RouteStatus.home;
  } else if (page.child is CFVideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else {
    return RouteStatus.unknow;
  }
}

// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;
  RouteStatusInfo(this.routeStatus, this.page);
}

// 舰艇路由页面跳转
// 感知当前页面是否后台

class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;

  List<RouteChangeListener> _listeners = [];

  RouteStatusInfo? _current;

  // 首页底部tabbar
  RouteStatusInfo? _bottomTab;

  HiNavigator._();
  static HiNavigator getInstantce() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  // tabbar切换监听
  void onTabBarChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  // 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  // 舰艇路由页面跳转
  void addLListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeLListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump!.onJumpTo(routeStatus, args: args);
  }

  // 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prevPages) {
    if (currentPages == prevPages) {
      return;
    }
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is CFTabBar && _bottomTab != null) {
      //打开的是首页，明确到首页具体的tab
      current = _bottomTab!;
    }
    print("hi_navigator:current:${current.page}");
    print("hi_navigator:prev:${_current?.page}");
    _listeners.forEach((element) {
      element(current, _current!);
    });
    _current = current;
  }

  getCurrent() {}
}

// 抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  OnJumpTo onJumpTo;
  RouteJumpListener(this.onJumpTo);
}
