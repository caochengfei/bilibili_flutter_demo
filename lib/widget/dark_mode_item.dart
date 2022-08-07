import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

class DarkModeItem extends StatelessWidget {
  const DarkModeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon = themeProvider.isDark()
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    return InkWell(
      onTap: () {
        HiNavigator.getInstantce().onJumpTo(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.px, left: 15.px, bottom: 15.px),
        margin: EdgeInsets.only(
          top: 15.px,
        ),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            Text(
              '夜间模式',
              style: TextStyle(fontSize: 15.px, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.px, left: 10.px),
              child: Icon(icon),
            )
          ],
        ),
      ),
    );
  }
}
