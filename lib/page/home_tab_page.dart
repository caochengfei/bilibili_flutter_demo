import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/dao/home_dao.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/widget/hi_banner.dart';
import 'package:bilibili_demo/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CFHomeTabPage extends StatefulWidget {
  final String? catogery;
  final List<BannerMo>? bannerList;
  const CFHomeTabPage({Key? key, this.catogery, this.bannerList})
      : super(key: key);

  @override
  State<CFHomeTabPage> createState() => _CFHomeTabPageState();
}

class _CFHomeTabPageState extends State<CFHomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoMo> videoList = [];
  var pageIndex = 1;
  ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      // 距离列表最底部距离
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      print(dis);
      if (dis < 300 && _loading == false) {
        _loadData(loadMore: true);
      }
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadData,
      color: primary,
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                axisDirection: AxisDirection.down,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  if (widget.bannerList != null)
                    StaggeredGridTile.fit(
                        crossAxisCellCount: 2, child: _banner()),
                  ...videoList.map((videoMo) {
                    return StaggeredGridTile.fit(
                        crossAxisCellCount: 1,
                        child: VideoCard(
                          videoMo: videoMo,
                        ));
                  })
                ],
              ),
            ),
          )),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: HiBanner(
        bannerList: widget.bannerList,
      ),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeDao.getData(widget.catogery ?? "",
          pageIndex: currentIndex, pageSize: 10);
      setState(() {
        if (loadMore && result.videoList != null) {
          if (result.videoList!.isNotEmpty) {
            videoList = [...videoList, ...result.videoList!];
            pageIndex++;
          }
        } else {
          videoList = result.videoList ?? [];
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        _loading = false;
      });
    } on NeedAuth catch (e) {
      _loading = false;
      print(e);
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      _loading = false;
      print(e);
      showWaarnToast(e.message);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
