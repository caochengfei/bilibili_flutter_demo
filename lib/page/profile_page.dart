import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFProfilePage extends StatefulWidget {
  const CFProfilePage({Key? key}) : super(key: key);

  @override
  State<CFProfilePage> createState() => _CFProfilePageState();
}

class _CFProfilePageState extends State<CFProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("我的"),
      ),
    );
  }
}
