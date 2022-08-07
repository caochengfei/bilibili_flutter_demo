import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _ITEMS = [
    {"name": "跟随系统", "mode": ThemeMode.system},
    {"name": "开启", "mode": ThemeMode.dark},
    {"name": "关闭", "mode": ThemeMode.light},
  ];

  var _currentTheme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var themeProvider = context.read<ThemeProvider>();
    _ITEMS.forEach((element) {
      if (element['mode'] == themeProvider.getThemeMode()) {
        _currentTheme = element;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('夜间模式'),
      ),
      body: ListView.builder(
        itemBuilder: itemBuilder,
        itemCount: _ITEMS.length,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return _item(index);
  }

  Widget _item(int index) {
    Map theme = _ITEMS[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        height: 50.px,
        child: Row(
          children: [
            Expanded(child: Text(theme['name'])),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _switchTheme(int index) {
    Map theme = _ITEMS[index];
    context.read<ThemeProvider>().setTheme(theme['mode']);
    setState(() {
      _currentTheme = theme;
    });
  }
}
