import 'dart:math';
import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/http/db/hi_cache.dart';
import 'package:bilibili_demo/http/request/notice_request.dart';
import 'package:bilibili_demo/http/request/test_request.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/page/dark_mode_page.dart';
import 'package:bilibili_demo/provider/hi_provider.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/hi_defend.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/page/home_page.dart';
import 'package:bilibili_demo/page/login_page.dart';
import 'package:bilibili_demo/page/regis_page.dart';
import 'package:bilibili_demo/page/video_detail_page.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:bilibili_demo/navigator/tabbar.dart';
import 'package:provider/provider.dart';

void main() {
  HIDefend().run(MyApp());
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
          return MultiProvider(
              providers: topProviders,
              child: Consumer<ThemeProvider>(builder:
                  (BuildContext context, ThemeProvider themeProvider, child) {
                return MaterialApp(
                  home: widget,
                  theme: themeProvider.getTheme(),
                  darkTheme: themeProvider.getTheme(isDarkMode: true),
                  themeMode: themeProvider.getThemeMode(),
                );
              }));
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  // ???navigator????????????key??????????????????????????????navigatorKey.currentState????????????NavigatorState??????
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //????????????????????????
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
  VideoModel? videoModel;

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
      // ????????????????????????????????????????????????????????????????????????????????????
      // tips ????????????????????????
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //???????????????????????????????????????????????????????????????
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
    } else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    }

    tempPages = [...tempPages, page];
    // ????????????????????????
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
            // ??????????????????????????????
            if ((route.settings as MaterialPage).child is CFLoginPage) {
              if (!hasLogin) {
                showWaarnToast("????????????");
                return false;
              }
            }
          }
          // ???????????????????????????????????????
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

// ??????????????????
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
