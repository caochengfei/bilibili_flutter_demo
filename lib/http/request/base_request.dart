import 'package:bilibili_demo/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

// 基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;
  // 参数
  Map<String, String> params = Map();
  // 请求头
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    'auth-token': 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa'
  };

  // 域名
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathString = path();

    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathString = "${path()}$pathParams";
      } else {
        pathString = "${path()}/$pathParams";
      }
    }

    // http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathString, params);
    } else {
      uri = Uri.http(authority(), pathString, params);
    }

    if (needLogin()) {
      //需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
      print("needLogin");
    }
    print("header:${header}");
    print("url:${uri.toString()}");
    return uri.toString();
  }

  bool needLogin();

  // 添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  // 添加header
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    print(header);
    return this;
  }
}
