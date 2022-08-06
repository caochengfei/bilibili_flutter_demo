import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/request/favorite_list_request.dart';
import 'package:bilibili_demo/model/favorite_mo.dart';

class FavoriteListDao {
  static getData({int pageIndex = 1, int pageSize = 10}) async {
    FavoriteListRequest request = FavoriteListRequest();
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    return FavoriteMo.fromJson(result['data']);
  }
}
