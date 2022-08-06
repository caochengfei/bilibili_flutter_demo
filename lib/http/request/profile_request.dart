import 'package:bilibili_demo/http/core/hi_base_request.dart';

import 'base_request.dart';

class ProfileRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    // TODO: implement needLogin
    return true;
  }

  @override
  String path() {
    // TODO: implement path
    return "uapi/fa/profile";
  }
}
