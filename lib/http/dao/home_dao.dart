import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/request/home_request.dart';
import 'package:bilibili_demo/model/home_mo.dart';

class HomeDao {
  static getData(String categoryName,
      {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    return HomeMo.fromJson(result['data']);
  }
}
