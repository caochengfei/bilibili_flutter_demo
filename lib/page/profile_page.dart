import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/dao/profile_dao.dart';
import 'package:bilibili_demo/model/profile_mo.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:bilibili_demo/widget/benefit_card.dart';
import 'package:bilibili_demo/widget/course_card.dart';
import 'package:bilibili_demo/widget/dark_mode_item.dart';
import 'package:bilibili_demo/widget/hi_banner.dart';
import 'package:bilibili_demo/widget/hi_blur.dart';
import 'package:bilibili_demo/widget/hi_flexible_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFProfilePage extends StatefulWidget {
  const CFProfilePage({Key? key}) : super(key: key);

  @override
  State<CFProfilePage> createState() => _CFProfilePageState();
}

class _CFProfilePageState extends State<CFProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileMo? _profileMo;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                _buildAppBar(),
              ];
            },
            body: ListView(
              padding: EdgeInsets.only(top: 10),
              children: [
                ..._buildContentList(),
              ],
            )));
  }

  void _loadData() async {
    try {
      ProfileMo result = await ProfileDao.getData();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      showWaarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
        name: _profileMo!.name!,
        face: _profileMo!.face!,
        controller: _scrollController);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _buildAppBar() {
    return SliverAppBar(
      //扩展高度
      expandedHeight: 160,
      // 标题是否固定
      pinned: true,
      // 定义滚动空间
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: cachedImage(
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.phbzj.com%2Fxiaohua%2F0906%2F090609115291.jpg&refer=http%3A%2F%2Fimg.phbzj.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662139998&t=660f9535aeb0e4420aecd22bbef4562e')),
            Positioned.fill(
                child: HiBlur(
              sigma: 20,
            )),
            Positioned(
              child: _buildProfileTab(),
              bottom: 0,
              left: 0,
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  _buildContentList() {
    if (_profileMo == null) return [];
    return [
      _buildBanner(),
      CourseCard(courseList: _profileMo!.courseList!),
      BenefitCard(benefitList: _profileMo!.benefitList!),
      DarkModeItem()
    ];
  }

  _buildBanner() {
    return HiBanner(
      bannerList: _profileMo!.bannerList!,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTab() {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileMo!.favorite!),
          _buildIconText("点赞", _profileMo!.like!),
          _buildIconText("浏览", _profileMo!.browsing!),
          _buildIconText("金币", _profileMo!.coin!),
          _buildIconText("粉丝", _profileMo!.fans!),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
