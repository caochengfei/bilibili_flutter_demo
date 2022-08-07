import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/format_util.dart';
import '../model/video_model.dart';
import '../util/rpx.dart';

class VideoHeader extends StatelessWidget {
  const VideoHeader(this.owner, {Key? key}) : super(key: key);
  final Owner owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.px, right: 15.px, left: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.px),
                child: Image.network(
                  owner.face ?? "",
                  width: 30.px,
                  height: 30.px,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.px),
                child: Column(
                  children: [
                    Text(
                      owner.name ?? "",
                      style: TextStyle(
                          fontSize: 13.px,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${countFormat(owner.fans ?? 0)}粉丝',
                      style: TextStyle(fontSize: 10.px, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              print("-------关注");
            },
            color: primary,
            height: 24.px,
            minWidth: 50.px,
            child: Text(
              "+关注",
              style: TextStyle(fontSize: 13.px, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
