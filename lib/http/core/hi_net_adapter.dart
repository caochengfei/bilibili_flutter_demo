import 'dart:convert';
import 'package:bilibili_demo/http/core/hi_base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse> send<T>(HiBaseRequest request);
}

// 统一网络层返回格式
class HiNetResponse<T> {
  dynamic data;
  HiBaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  HiNetResponse(this.data,
      {this.request, this.statusCode, this.statusMessage, this.extra});

  @override
  String toString() {
    // TODO: implement toString
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
