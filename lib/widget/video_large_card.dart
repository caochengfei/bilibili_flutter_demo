import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/format_util.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoModel? videoModel;
  const VideoLargeCard({Key? key, this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color textColor = themeProvider.isDark() ? Colors.white70 : Colors.black87;

    return GestureDetector(
      onTap: () {
        HiNavigator.getInstantce()
            .onJumpTo(RouteStatus.detail, args: {"videoMo": videoModel});
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.px, right: 15.px, bottom: 5.px),
        padding: EdgeInsets.only(bottom: 6.px),
        height: 106.px,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [_itemImage(context), _buildContent(textColor)],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90.px;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.px),
      child: Stack(
        children: [
          cachedImage(videoModel!.cover!,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5.px,
              right: 5.px,
              child: Container(
                padding: EdgeInsets.all(2.px),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(2.px)),
                child: Text(
                  dateFormat(videoModel!.duration!),
                  style: TextStyle(color: Colors.white, fontSize: 10.px),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent(Color textColor) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5.px, left: 8.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel?.title ?? "",
            style: TextStyle(fontSize: 12.px, color: textColor),
          ),
          _buildBottonContent(textColor)
        ],
      ),
    ));
  }

  _buildBottonContent(Color textColor) {
    return Column(
      children: [
        // ??????
        _owner(),
        hiSpace(height: 5.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, videoModel?.view ?? ""),
                hiSpace(width: 5.px),
                ...smallIconText(Icons.list_alt, videoModel?.reply ?? "")
              ],
            ),
            Icon(
              Icons.more_vert_sharp,
              color: Colors.grey,
              size: 15.px,
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
          padding: EdgeInsets.all(1.px),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.px),
              border: Border.all(color: Colors.grey)),
          child: Text(
            "UP",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 8.px,
                fontWeight: FontWeight.bold),
          ),
        ),
        hiSpace(width: 8.px),
        Text(
          owner?.name ?? "",
          style: TextStyle(fontSize: 11.px, color: Colors.grey),
        )
      ],
    );
  }
}
