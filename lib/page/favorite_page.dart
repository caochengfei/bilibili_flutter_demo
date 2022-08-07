import 'package:bilibili_demo/http/core/hi_base_tab_state.dart';
import 'package:bilibili_demo/http/dao/favorite_dao.dart';
import 'package:bilibili_demo/http/dao/favorite_list_dao.dart';
import 'package:bilibili_demo/model/favorite_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/page/video_detail_page.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:bilibili_demo/widget/navigationbar.dart';
import 'package:bilibili_demo/widget/video_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/rpx.dart';

class CFFavoritePage extends StatefulWidget {
  const CFFavoritePage({Key? key}) : super(key: key);

  @override
  _CFFavoritePageState createState() => _CFFavoritePageState();
}

class _CFFavoritePageState
    extends HiBaseTabState<FavoriteMo, VideoModel, CFFavoritePage> {
  @override
  var listener;
  void initState() {
    // TODO: implement initState
    super.initState();
    this.listener = (current, prev) {
      if (prev?.page is CFVideoDetailPage && current.page is CFFavoritePage) {
        loadData();
      }
    };
    HiNavigator.getInstantce().addLListener(this.listener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HiNavigator.getInstantce().removeLListener(this.listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildNavigationBar(), Expanded(child: super.build(context))],
    );
  }

  _buildNavigationBar() {
    return CFNavigationBar(
      child: Container(
        decoration: bottomBoxShadow(context),
        alignment: Alignment.center,
        child: Text(
          "收藏",
          style: TextStyle(fontSize: 16.px),
        ),
      ),
    );
  }

  @override
  // TODO: implement contentChild
  get contentChild => Container(
      child: ListView.builder(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10.px),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return VideoLargeCard(
              videoModel: dataList[index],
            );
          }));

  @override
  Future<FavoriteMo> getData(int pageIndex) async {
    // TODO: implement getData
    FavoriteMo result = await FavoriteListDao.getData();
    return result;
  }

  @override
  List<VideoModel> parseList(FavoriteMo result) {
    // TODO: implement parseList
    return result.list ?? [VideoModel()];
  }
}
