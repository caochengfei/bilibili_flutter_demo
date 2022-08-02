import 'package:bilibili_demo/model/video_detail_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/format_util.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoToolBar extends StatelessWidget {
  final VideoDetailMo? detailMo;
  final VideoModel? videoModel;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? OnShare;
  const VideoToolBar(
      {Key? key,
      this.detailMo,
      this.videoModel,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavorite,
      this.OnShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded, videoModel?.like,
              onClick: onLike, tint: detailMo!.isLike),
          _buildIconText(Icons.thumb_down_alt_rounded, "不喜欢",
              onClick: onUnLike),
          _buildIconText(Icons.monetization_on, videoModel?.coin,
              onClick: onCoin),
          _buildIconText(Icons.grade_rounded, videoModel?.favorite,
              onClick: onFavorite, tint: detailMo!.isFavorite),
          _buildIconText(Icons.share_rounded, videoModel?.share,
              onClick: onLike),
        ],
      ),
    );
  }

  _buildIconText(IconData icon, var text, {onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else if (text == null) {
      text = "";
    }
    tint = tint == null ? false : tint;
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            icon,
            color: tint ? primary : Colors.grey,
          ),
          hiSpace(height: 5),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
