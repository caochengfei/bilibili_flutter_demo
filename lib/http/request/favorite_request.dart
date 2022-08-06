import 'package:bilibili_demo/http/core/hi_base_request.dart';
import 'base_request.dart';

class FavoriteRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    // TODO: implement needLogin
    return true;
  }

  @override
  String path() {
    // TODO: implement path
    return 'uapi/fa/favorite';
  }
}
