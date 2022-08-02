import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CFVideoDetailPage extends StatefulWidget {
  const CFVideoDetailPage({Key? key, this.videoModel}) : super(key: key);
  final VideoMo? videoModel;

  @override
  State<CFVideoDetailPage> createState() => _CFVideoDetailPageState();
}

class _CFVideoDetailPageState extends State<CFVideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [_videoView()],
        ));
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model?.url ?? "",
      cover: model?.cover ?? "",
    );
  }
}
