import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/core/hi_base_request.dart';
import 'package:bilibili_demo/http/request/cancel_favorite_request.dart';
import 'package:bilibili_demo/http/request/favorite_request.dart';

import '../request/base_request.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}
