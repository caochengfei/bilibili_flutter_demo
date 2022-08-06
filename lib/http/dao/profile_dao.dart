import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/request/profile_request.dart';
import 'package:bilibili_demo/model/profile_mo.dart';

class ProfileDao {
  static getData() async {
    ProfileRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    return ProfileMo.fromJson(result['data']);
  }
}
