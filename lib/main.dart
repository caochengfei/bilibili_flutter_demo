import 'dart:math';
import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/http/db/hi_cache.dart';
import 'package:bilibili_demo/http/request/notice_request.dart';
import 'package:bilibili_demo/http/request/test_request.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/page/home_page.dart';
import 'package:bilibili_demo/page/login_page.dart';
import 'package:bilibili_demo/page/regis_page.dart';
import 'package:bilibili_demo/page/video_detail_page.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:bilibili_demo/navigator/tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  @override
  Widget build(BuildContext context) {
    var widget = Router(routerDelegate: _routeDelegate);
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MaterialApp(
            home: widget,
            theme: ThemeData(primaryColor: Colors.white),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  // 为navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstantce()
        .registerRouteJump(RouteJumpListener((RouteStatus status, {Map? args}) {
      _routeStatus = status;
      if (routeStatus == RouteStatus.detail) {
        this.videoModel = args?['videoMo'];
      }
      notifyListeners();
    }));
  }
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoMo? videoModel;

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.regis && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的牙面在栈中存在，则将该页面和它上面的所有页面出栈
      // tips 具体规则按需调整
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转到首页时候要吧其他页面出栈，首页不可退
      pages.clear();
      page = pageWrap(CFTabBar());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(CFVideoDetailPage(
        videoModel: videoModel,
      ));
    } else if (routeStatus == RouteStatus.regis) {
      page = pageWrap(CFRegisPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(CFLoginPage());
    }

    tempPages = [...tempPages, page];
    // 通知路由发生变化
    print("pop: - $tempPages, $pages");
    HiNavigator.getInstantce().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKey.currentState!.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            // 登录也未登录返回拦截
            if ((route.settings as MaterialPage).child is CFLoginPage) {
              if (!hasLogin) {
                showWaarnToast("请先登录");
                return false;
              }
            }
          }
          // 在这里可以控制是否可以返回
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];

          pages.removeLast();
          print("pop: - $pages, $tempPages");
          HiNavigator.getInstantce().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}

// 创建路由页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
