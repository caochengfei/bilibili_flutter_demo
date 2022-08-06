import 'dart:io';

import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/format_util.dart';
import 'package:bilibili_demo/widget/navigationbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: BoxFit.cover,
    placeholder: (context, url) => Container(
      color: Colors.grey[200],
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ],
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter);
}

smallIconText(IconData icon, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      icon,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      text,
      style: style,
    )
  ];
}

borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey);
  return Border(
      bottom: bottom ? borderSide : BorderSide.none,
      top: top ? borderSide : BorderSide.none);
}

SizedBox hiSpace({double height: 1, double width: 1}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

BoxDecoration? bottomBoxShadow(BuildContext context) {
  var themeProvider = context.watch<ThemeProvider>();
  if (themeProvider.isDark()) {
    return null;
  }
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
        color: Colors.grey,
        offset: Offset(0, 2),
        blurRadius: 1.0,
        spreadRadius: 0.3)
  ]);
}

///修改状态栏
void changeStatusBar(
    {color: Colors.white,
    StatusStyle statusStyle: StatusStyle.DARK,
    BuildContext? context}) {
  if (context != null) {
    //fix Tried to listen to a value exposed with provider, from outside of the widget tree.
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (themeProvider.isDark()) {
      statusStyle = StatusStyle.LIGHT;
      color = HiColor.dark_bg;
    }
  }
  // var page = HiNavigator.getInstantce().getCurrent()?.page;
  // //fix Android切换 profile页面状态栏变白问题
  // if (page is ProfilePage) {
  //   color = Colors.transparent;
  // } else if (page is VideoDetailPage) {
  //   color = Colors.black;
  //   statusStyle = StatusStyle.LIGHT_CONTENT;
  // }
  //沉浸式状态栏样式
  var brightness;
  if (Platform.isIOS) {
    brightness =
        statusStyle == StatusStyle.LIGHT ? Brightness.dark : Brightness.light;
  } else {
    brightness =
        statusStyle == StatusStyle.DARK ? Brightness.light : Brightness.dark;
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
  ));
}
