import 'package:bilibili_demo/http/core/hi_base_tab_state.dart';
import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/dao/home_dao.dart';
import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
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
  HiBaseTabState<HomeMo, VideoModel, CFHomeTabPage> createState() =>
      _CFHomeTabPageState();
}

class _CFHomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, CFHomeTabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.catogery);
    print(widget.bannerList);
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: HiBanner(
        bannerList: widget.bannerList,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  get contentChild => SingleChildScrollView(
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          axisDirection: AxisDirection.down,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            if (widget.bannerList != null)
              StaggeredGridTile.fit(crossAxisCellCount: 2, child: _banner()),
            ...dataList.map((videoMo) {
              return StaggeredGridTile.fit(
                  crossAxisCellCount: 1,
                  child: VideoCard(
                    videoMo: videoMo,
                  ));
            })
          ],
        ),
      );

  @override
  Future<HomeMo> getData(int pageIndex) async {
    // TODO: implement getData
    HomeMo result = await HomeDao.getData(widget.catogery ?? "",
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    // TODO: implement parseList
    return result.videoList ?? [VideoModel()];
  }
}
