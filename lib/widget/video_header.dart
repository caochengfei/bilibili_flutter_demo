import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/format_util.dart';
import '../model/video_model.dart';

class VideoHeader extends StatelessWidget {
  const VideoHeader(this.owner, {Key? key}) : super(key: key);
  final Owner owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  owner.face ?? "",
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Text(
                      owner.name ?? "",
                      style: TextStyle(
                          fontSize: 13,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${countFormat(owner.fans ?? 0)}粉丝',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
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
            height: 24,
            minWidth: 50,
            child: Text(
              "+关注",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
