import 'package:bilibili_demo/http/core/hi_net_adapter.dart';
import 'hi_base_request.dart';
import '../core/hi_net_adapter.dart';

// 测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) {
    return Future<HiNetResponse<T>>.delayed(Duration(microseconds: 20000), () {
      return HiNetResponse({"code": 0, "message": "success"}, statusCode: 200);
    });
  }
}
