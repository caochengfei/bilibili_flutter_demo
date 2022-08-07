import 'package:bilibili_demo/model/home_mo.dart';
import 'package:bilibili_demo/model/video_model.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../util/rpx.dart';

class HiBanner extends StatelessWidget {
  const HiBanner(
      {Key? key, this.bannerList, this.bannerHeight = 160, this.padding})
      : super(key: key);
  final List<BannerMo>? bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight.px,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10.px + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList?.length ?? 0,
      autoplay: true,
      itemBuilder: (context, index) {
        return _image(bannerList != null ? bannerList![index] : null);
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10.px),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6.px, activeSize: 6.px)),
    );
  }

  _image(BannerMo? model) {
    if (model == null) {
      return InkWell();
    }
    return InkWell(
      onTap: () {
        _handleClick(model);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6.px)),
          child: Image.network(
            model.cover!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo? model) {
    if (model?.type == "video") {
      HiNavigator.getInstantce().onJumpTo(RouteStatus.detail,
          args: {"video": VideoModel(vid: model!.url)});
    } else {
      print(model?.url);
      //todo
    }
  }
}
