import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFRankingPage extends StatefulWidget {
  const CFRankingPage({Key? key}) : super(key: key);

  @override
  State<CFRankingPage> createState() => _CFRankingPageState();
}

class _CFRankingPageState extends State<CFRankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("排行"),
      ),
    );
  }
}
