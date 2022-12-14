import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/db/hi_cache.dart';
import 'package:bilibili_demo/http/core/hi_base_request.dart';
import 'package:bilibili_demo/http/request/login_request.dart';
import 'package:bilibili_demo/http/request/regis_request.dart';
import 'package:flutter/material.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static regis(
      String userName, String password, String imoocId, String orderId) {
    _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    HiBaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegisRequest();
    } else {
      request = LoginRequest();
    }

    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);

    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
