import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_state.dart';
import 'package:bilibili_demo/http/dao/home_dao.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/page/home_tab_page.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../http/dao/home_dao.dart';
import '../widget/navigationbar.dart';

class CFHomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const CFHomePage({Key? key, this.onJumpTo}) : super(key: key);
  @override
  State<CFHomePage> createState() => _CFHomePageState();
}

class _CFHomePageState extends HiState<CFHomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  TabController? _controller;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    this.listener = (current, prev) {
      print("current:${current.page}");
      print("prev:${prev?.page}");
      if (widget == current.page || current.page is CFHomePage) {
        print("打开了首页, OnResume");
      } else if (widget == prev?.page || prev?.page is CFHomePage) {
        print("离开了首页, OnPause ");
      }
    };
    HiNavigator.getInstantce().addLListener(this.listener);
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HiNavigator.getInstantce().removeLListener(this.listener);
    listener = null;
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingContainer(
      isLoading: _isLoading,
      child: Column(
        children: [
          CFNavigationBar(
            height: 50,
            child: _appBar(),
            color: Colors.white,
            statusStyle: StatusStyle.DARK,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
            children: categoryList.map((tab) {
              return CFHomeTabPage(
                catogery: tab.name ?? "",
                bannerList: tab.name == "推荐" ? bannerList : null,
              );
            }).toList(),
            controller: _controller,
          ))
        ],
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineTabIndicator(
            insets: EdgeInsets.only(left: 15, right: 15),
            borderSide: BorderSide(color: primary, width: 3)),
        tabs: categoryList.map<Tab>((tab) {
          return Tab(
            child: Padding(
              child: Text(tab.name ?? ""),
              padding: EdgeInsets.all(0),
            ),
          );
        }).toList());
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.getData('推荐');
      if (result.categoryList != null) {
        _controller =
            TabController(length: result.categoryList!.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList!;
        bannerList = result.bannerList ?? [];
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWaarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      print(e);
      showWaarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                image: AssetImage('images/avatar.png'),
                height: 46,
                width: 46,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
