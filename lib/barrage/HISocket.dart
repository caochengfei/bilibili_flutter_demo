import 'dart:ffi';

import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/model/barrage_mo.dart';
import 'package:bilibili_demo/util/hi_constants.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HiSocket extends ISocket {
  static const _URL = 'wss://api.devio.org/uapi/fa/barrage/';
  late IOWebSocketChannel _channel;
  late ValueChanged<List<BarrageModel>> _callBack;
  // 心跳间隔秒数
  int _intervalSeconds = 50;

  @override
  void close() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    // TODO: implement listen
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    // TODO: implement open
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print("连接发生错误$error");
    }).listen((message) {
      _handleMessage(message);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    // TODO: implement send
    _channel.sink.add(message);
    return this;
  }

  _headers() {
    Map<String, dynamic> header = {
      HiConstants.autuTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }

  // 处理服务端的返回
  void _handleMessage(message) {
    print('received: $message');
    var result = BarrageModel.fromJsonString(message);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }
}

abstract class ISocket {
  // 建立连接
  ISocket open(String vid);
  // 发送弹幕
  ISocket send(String message);
  // 关闭连接
  void close();
  // 接受弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
