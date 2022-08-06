import 'package:bilibili_demo/http/core/dio_adapter.dart';
import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_net_adapter.dart';
import 'package:bilibili_demo/http/core/mock_adapter.dart';
import 'package:bilibili_demo/http/core/hi_base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(HiBaseRequest request) async {
    late HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    printLog(result);

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
        break;
      case 401:
        throw NeedLogin();
        break;
      case 403:
        throw NeedAuth(result.toString(), data: result);
        break;
      default:
        throw HiNetError(status ?? 400, result);
    }

    return result;
  }

  Future<dynamic> send<T>(HiBaseRequest request) async {
    printLog("url:${request.url()}");

    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print("hi_net:${log.toString()}");
  }
}
