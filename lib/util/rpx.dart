import 'dart:ui';

extension doubleFit on double {
  double get px {
    return HiSizeFit.instaince.setPx(this);
  }

  double get rpx {
    return HiSizeFit.instaince.setRpx(this);
  }
}

extension intFit on int {
  double get px {
    return HiSizeFit.instaince.setPx(this.toDouble());
  }

  double get rpx {
    return HiSizeFit.instaince.setRpx(this.toDouble());
  }
}

class HiSizeFit {
  late double physicalWidth;
  late double physicalHeight;
  late double screenWidth;
  late double screenHeight;
  late double dpr;
  late double statusHeight;
  late double rpx;
  late double px;

  static HiSizeFit? _instaince;
  static get instaince {
    if (_instaince == null) {
      _instaince = HiSizeFit._internal();
      _instaince?.initialize();
    }
    return _instaince;
  }

  HiSizeFit._internal();

  initialize({double standardSize = 750}) {
    // 手机物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    dpr = window.devicePixelRatio;

    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    statusHeight = window.padding.top / dpr;

    rpx = screenWidth / standardSize;

    px = screenWidth / standardSize * 2;
  }

  double setRpx(double size) {
    return _instaince!.rpx * size;
  }

  double setPx(double size) {
    return _instaince!.px * size;
  }
}
