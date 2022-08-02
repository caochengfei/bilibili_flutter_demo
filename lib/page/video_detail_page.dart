import 'dart:io';

import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/dao/favorite_dao.dart';
import 'package:bilibili_demo/http/dao/video_detail_dao.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/model/video_detail_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/widget/appbar.dart';
import 'package:bilibili_demo/widget/expansion_tile.dart';
import 'package:bilibili_demo/widget/hi_tab.dart';
import 'package:bilibili_demo/widget/navigationbar.dart';
import 'package:bilibili_demo/widget/video_header.dart';
import 'package:bilibili_demo/widget/video_large_card.dart';
import 'package:bilibili_demo/widget/video_tool_bar.dart';
import 'package:bilibili_demo/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/video_model.dart';

class CFVideoDetailPage extends StatefulWidget {
  const CFVideoDetailPage({Key? key, this.videoModel}) : super(key: key);
  final VideoModel? videoModel;

  @override
  State<CFVideoDetailPage> createState() => _CFVideoDetailPageState();
}

class _CFVideoDetailPageState extends State<CFVideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ["简介", "评论"];
  VideoDetailMo? videoDetailMo;
  List<VideoModel>? videoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    _loadDetail();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              children: [
                if (Platform.isIOS)
                  CFNavigationBar(
                    color: Colors.black,
                    statusStyle: StatusStyle.LIGHT,
                  ),
                _buildVideoView(),
                _buildTabNavigation(),
                Flexible(
                    child: TabBarView(
                  children: [
                    _buildDetailList(),
                    Container(
                      child: Text("敬请期待"),
                    )
                  ],
                  controller: _controller,
                ))
              ],
            )));
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model?.url ?? "",
      cover: model?.cover ?? "",
      overlayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
      unselectedLabelColor: Colors.grey,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [...buildContents(), ..._buildVideoList()],
    );
  }

  buildContents() {
    return [
      VideoHeader(widget.videoModel!.owner!),
      ExpandableContent(widget.videoModel ?? VideoModel()),
      VideoToolBar(
        detailMo: videoDetailMo ?? VideoDetailMo(),
        videoModel: videoDetailMo?.videoInfo,
        onFavorite: _onFavorite,
        onLike: _doLike,
        onUnLike: _onUnLike,
      )
    ];
  }

  _loadDetail() async {
    try {
      VideoDetailMo result =
          await VideoDetailDao.getData(widget.videoModel!.vid!);
      setState(() {
        videoDetailMo = result;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      showWaarnToast(e.message);
    }
  }

  void _doLike() {}

  void _onUnLike() {}

  void _onFavorite() async {
    try {
      var result = await FavoriteDao.favorite(
          videoDetailMo?.videoInfo?.vid ?? "",
          !(videoDetailMo?.isFavorite ?? false));
      videoDetailMo?.isFavorite = !(videoDetailMo?.isFavorite ?? false);
      int num = videoDetailMo?.videoInfo?.favorite ?? 0;
      if (videoDetailMo?.isFavorite == true) {
        videoDetailMo?.videoInfo?.favorite = num += 1;
      } else {
        videoDetailMo?.videoInfo?.favorite = num -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
      });
    } on NeedAuth catch (e) {
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      showWaarnToast(e.message);
    }
  }

  _buildVideoList() {
    if (videoList == null) {
      return [Container()];
    }
    return videoList
        ?.map((mo) => VideoLargeCard(
              videoModel: mo,
            ))
        .toList();
  }
}
