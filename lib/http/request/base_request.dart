import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/http/core/hi_base_request.dart';
import 'package:bilibili_demo/util/hi_constants.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    if (needLogin()) {
      //需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
      print("needLogin");
    }
    return super.url();
  }

  // 请求头
  Map<String, dynamic> header = {
    HiConstants.autuTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV
  };

  HttpMethod httpMethod();

  String path();
}
