import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFFavoritePage extends StatefulWidget {
  const CFFavoritePage({Key? key}) : super(key: key);

  @override
  State<CFFavoritePage> createState() => _CFFavoritePageState();
}

class _CFFavoritePageState extends State<CFFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("收藏"),
      ),
    );
  }
}
