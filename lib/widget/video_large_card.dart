import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/util/format_util.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoModel? videoModel;
  const VideoLargeCard({Key? key, this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstantce()
            .onJumpTo(RouteStatus.detail, args: {"videoMo": videoModel});
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [_itemImage(context), _buildContent()],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoModel!.cover!,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(2)),
                child: Text(
                  dateFormat(videoModel!.duration!),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel?.title ?? "",
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _buildBottonContent()
        ],
      ),
    ));
  }

  _buildBottonContent() {
    return Column(
      children: [
        // 作者
        _owner(),
        hiSpace(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, videoModel?.view ?? ""),
                hiSpace(width: 5),
                ...smallIconText(Icons.list_alt, videoModel?.reply ?? "")
              ],
            ),
            Icon(
              Icons.more_vert_sharp,
              color: Colors.grey,
              size: 15,
            )
          ],
        )
      ],
    );
  }

  _owner() {
    var owner = videoModel?.owner;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey)),
          child: Text(
            "UP",
            style: TextStyle(
                color: Colors.grey, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
        hiSpace(width: 8),
        Text(
          owner?.name ?? "",
          style: TextStyle(fontSize: 11, color: Colors.grey),
        )
      ],
    );
  }
}
