import 'package:bilibili_demo/http/dao/rank_dao.dart';
import 'package:bilibili_demo/page/rank_tab_page.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:bilibili_demo/widget/hi_tab.dart';
import 'package:bilibili_demo/widget/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFRankingPage extends StatefulWidget {
  const CFRankingPage({Key? key}) : super(key: key);

  @override
  State<CFRankingPage> createState() => _CFRankingPageState();
}

class _CFRankingPageState extends State<CFRankingPage>
    with TickerProviderStateMixin {
  @override
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];
  TabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
    RankDao.getData("like");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [_buildNavigationBar(), _buildTabView()],
    ));
  }

  _buildNavigationBar() {
    return CFNavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: _tabBar(),
        decoration: bottomBoxShadow(),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      TABS.map<Tab>((tab) {
        return Tab(
          text: tab['name'],
        );
      }).toList(),
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
    );
  }

  _buildTabView() {
    return Flexible(
        child: TabBarView(
            controller: _controller,
            children: TABS.map((tab) {
              return RankTabPage(
                sort: tab['key'],
              );
            }).toList()));
  }
}
