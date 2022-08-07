import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/format_util.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, this.videoMo}) : super(key: key);
  final VideoModel? videoMo;

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color textColor = themeProvider.isDark() ? Colors.white70 : Colors.black87;
    return InkWell(
        onTap: () {
          print(videoMo?.url);
          HiNavigator.getInstantce()
              .onJumpTo(RouteStatus.detail, args: {"videoMo": videoMo});
        },
        child: SizedBox(
          height: 200.px,
          child: Card(
            // 取消卡片边距
            margin: EdgeInsets.only(left: 4.px, right: 4.px, bottom: 8.px),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_itemImage(context), _infoText(textColor)],
              ),
            ),
          ),
        ));
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(videoMo?.cover ?? "",
            width: size.width / 2 - 10.px, height: 100.px),
        Positioned(
          child: Container(
              padding: EdgeInsets.only(
                  left: 8.px, right: 8.px, bottom: 3.px, top: 5.px),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video, videoMo?.view),
                  _iconText(Icons.favorite_border, videoMo?.favorite),
                  _iconText(null, videoMo?.duration),
                ],
              )),
          left: 0,
          right: 0,
          bottom: 0,
        )
      ],
    );
  }

  _iconText(IconData? icon, int? count) {
    String views = "";
    if (IconData != null) {
      views = countFormat(count ?? 0);
    } else {
      views = dateFormat(videoMo?.duration ?? 0);
    }
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.white,
            size: 12.px,
          ),
        Padding(
          padding: EdgeInsets.only(left: 3.px),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10.px),
          ),
        )
      ],
    );
  }

  _infoText(Color textColor) {
    return Expanded(
        child: Container(
      padding:
          EdgeInsets.only(top: 5.px, left: 8.px, right: 8.px, bottom: 5.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoMo?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12.px, color: textColor),
          ),
          _onwer(textColor)
        ],
      ),
    ));
  }

  _onwer(Color textColor) {
    var owner = videoMo?.owner ?? Owner();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.px),
              child: cachedImage(owner.face ?? "", width: 24.px, height: 24.px),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.px),
              child: Text(
                owner.name ?? "",
                style: TextStyle(fontSize: 11.px, color: textColor),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15.px,
          color: Colors.grey,
        ),
      ],
    );
  }
}
