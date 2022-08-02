import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/request/video_detail_request.dart';
import 'package:bilibili_demo/model/video_detail_mo.dart';

class VideoDetailDao {
  static getData(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return VideoDetailMo.fromJson(result['data']);
  }
}
