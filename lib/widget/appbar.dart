import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback? rightButtonClick) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(
      color: Colors.grey,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 18, color: Colors.grey),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

videoAppBar() {
  return Container(
    padding: EdgeInsets.only(right: 8),
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
              size: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20,
                ))
          ],
        )
      ],
    ),
  );
}
