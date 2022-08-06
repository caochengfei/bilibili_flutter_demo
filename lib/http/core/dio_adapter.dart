import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_net_adapter.dart';
import 'package:dio/dio.dart';

import '../core/hi_net_adapter.dart';
import 'hi_base_request.dart';

class DioAdapter extends HiNetAdapter {
  Future<HiNetResponse> send<T>(HiBaseRequest request) async {
    late Response response;
    Options option = Options(headers: request.header);
    print("dio:header: ${request.header}");
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: option);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: option);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: option);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response!;
    }
    if (error != null) {
      throw HiNetError(response.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  HiNetResponse buildRes(Response response, HiBaseRequest request) {
    return HiNetResponse(response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
