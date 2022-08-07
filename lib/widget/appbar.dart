import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import '../util/rpx.dart';

appBar(String title, String rightTitle, VoidCallback? rightButtonClick) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(
      color: Colors.grey,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 18.px, color: Colors.grey),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15.px, right: 15.px),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18.px, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

videoAppBar() {
  return Container(
    padding: EdgeInsets.only(right: 8.px),
    decoration: BoxDecoration(
      gradient: blackLinearGradient(fromTop: true),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
            Icon(
              Icons.live_tv_rounded,
              color: Colors.white,
              size: 20.px,
            ),
            Padding(
                padding: EdgeInsets.only(left: 12.px),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20.px,
                ))
          ],
        )
      ],
    ),
  );
}
