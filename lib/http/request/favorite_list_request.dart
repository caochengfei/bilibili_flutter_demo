import 'package:bilibili_demo/http/core/hi_base_request.dart';
import 'package:bilibili_demo/http/request/base_request.dart';

class FavoriteListRequest extends BaseRequest {
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
    return 'uapi/fa/favorites';
  }
}
