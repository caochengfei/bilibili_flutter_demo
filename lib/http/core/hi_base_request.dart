enum HttpMethod { GET, POST, DELETE }

// 基础请求
abstract class HiBaseRequest {
  var pathParams;
  var useHttps = true;
  // 参数
  Map<String, String> params = Map();
  // 请求头
  Map<String, dynamic> header = {};

  // 域名
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathString = path();

    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathString = "${path()}$pathParams";
      } else {
        pathString = "${path()}/$pathParams";
      }
    }

    // http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathString, params);
    } else {
      uri = Uri.http(authority(), pathString, params);
    }

    print("header:${header}");
    print("url:${uri.toString()}");
    return uri.toString();
  }

  bool needLogin();

  // 添加参数
  HiBaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  // 添加header
  HiBaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    print(header);
    return this;
  }
}
