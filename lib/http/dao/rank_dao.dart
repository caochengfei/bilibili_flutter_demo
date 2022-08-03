import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/request/rank_request.dart';
import 'package:bilibili_demo/model/rank_mo.dart';

class RankDao {
  static getData(String sort, {int pageIndex = 1, pageSize = 10}) async {
    RankRequest request = RankRequest();
    request
        .add("sort", sort)
        .add("pageIndex", pageIndex)
        .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    return RankMo.fromJson(result['data']);
  }
}
