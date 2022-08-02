import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/page/favorite_page.dart';
import 'package:bilibili_demo/page/home_page.dart';
import 'package:bilibili_demo/page/profile_page.dart';
import 'package:bilibili_demo/page/ranking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/color.dart';

class CFTabBar extends StatefulWidget {
  const CFTabBar({Key? key}) : super(key: key);

  @override
  State<CFTabBar> createState() => _CFTabBarState();
}

class _CFTabBarState extends State<CFTabBar> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  List<Widget> _pages = [];
  bool _hasBuild = false;
  static int initPage = 0;

  @override
  Widget build(BuildContext context) {
    _pages = [
      CFHomePage(
        onJumpTo: (index) {
          _onJumpTo(index, pageChange: false);
        },
      ),
      CFRankingPage(),
      CFFavoritePage(),
      CFProfilePage(),
    ];
    if (_hasBuild == false) {
      // 第一次打开页面时候通知打开的是哪个tab
      HiNavigator.getInstantce().onTabBarChange(initPage, _pages[initPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onJumpTo(index),
        selectedItemColor: _activeColor,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3),
        ],
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }

  _bottomItem(String title, IconData icon, int Index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: title);
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstantce().onTabBarChange(index, _pages[index]);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
