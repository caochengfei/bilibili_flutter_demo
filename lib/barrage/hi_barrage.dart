import 'dart:async';
import 'dart:math';

import 'package:bilibili_demo/barrage/HISocket.dart';
import 'package:bilibili_demo/barrage/barrage_item.dart';
import 'package:bilibili_demo/barrage/barrage_view_util.dart';
import 'package:bilibili_demo/barrage/ibarrage.dart';
import 'package:bilibili_demo/model/barrage_mo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum BarrageStatus { play, pause }

// 弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;
  const HiBarrage(
      {Key? key,
      this.lineCount = 4,
      required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  State<HiBarrage> createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements Ibarrage {
  late HiSocket _hiSocket;
  late double _height;
  late double _widht;
  List<BarrageItem> _barrageItemList = [];
  List<BarrageModel> _barrageModelList = [];
  int _barrageIndex = 0; // 第几条弹幕
  Random _random = Random();
  // ignore: non_constant_identifier_names
  BarrageStatus _barrageStatus = BarrageStatus.play;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hiSocket = HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_hiSocket != null) {
      _hiSocket.close();
    }
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _widht = MediaQuery.of(context).size.width;
    _height = _widht / 16 * 9;
    return SizedBox(
      width: _widht,
      height: _height,
      child: Stack(
        children: [Container()]..addAll(_barrageItemList),
      ),
    );
  }

  void _handleMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, modelList);
    } else {
      _barrageModelList.addAll(modelList);
    }
    // 收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    // 收到新的弹幕后播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("action: play");
    if (_timer != null && _timer?.isActive == true) {
      return;
    }
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        // 将发送的弹幕从集合中移除
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print('start:${temp.content}');
      } else {
        // 弹幕发送完毕后关闭定时器
        _timer?.cancel();
        print('end: barrage');
      }
    });
  }

  // 添加弹幕
  void addBarrage(BarrageModel model) {
    //todo:
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    String id = '${_random.nextInt(10000)}:${model.content}';
    var item = BarrageItem(
        id: id,
        top: top,
        child: BarrageViewUtil.barrageView(model),
        onComplete: _onComplete);
    _barrageItemList.add(item);
    setState(() {});
  }

  @override
  void pause() {
    // TODO: implement pause
    _barrageStatus = BarrageStatus.pause;
    // 清空屏幕上的弹幕
    _barrageItemList.clear();
    setState(() {
      print('action:pause');
    });
    _timer?.cancel();
  }

  @override
  void send(String message) {
    // TODO: implement send
    if (message == null) {
      return;
    }
    _hiSocket.send(message);
    _handleMessage(
        [BarrageModel(content: message, vid: "-1", priority: 1, type: 1)]);
  }

  void _onComplete(id) {
    print('Done: $id');
    // 弹幕播放完毕从弹幕widget集合移除
    _barrageItemList.removeWhere((model) {
      return model.id == id;
    });
  }
}
