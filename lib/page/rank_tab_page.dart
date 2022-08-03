import 'package:bilibili_demo/http/core/hi_base_tab_state.dart';
import 'package:bilibili_demo/http/dao/rank_dao.dart';
import 'package:bilibili_demo/model/rank_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/widget/video_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RankTabPage extends StatefulWidget {
  final String? sort;
  const RankTabPage({Key? key, this.sort = "like"}) : super(key: key);

  @override
  State<RankTabPage> createState() => _RankTabPageState();
}

class _RankTabPageState
    extends HiBaseTabState<RankMo, VideoModel, RankTabPage> {
  @override
  get contentChild => Container(
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10),
          itemCount: dataList.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return VideoLargeCard(
              videoModel: dataList[index],
            );
          }));

  @override
  Future<RankMo> getData(int pageIndex) async {
    // TODO: implement getData
    RankMo result =
        await RankDao.getData(widget.sort!, pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(RankMo result) {
    // TODO: implement parseList
    return result.list ?? [VideoModel()];
  }
}
