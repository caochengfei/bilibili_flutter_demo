import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HIDefend {
  run(Widget app) {
    FlutterError.onError = (details) {
      // 线上环境上报
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        // 开发期间
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(body(app), onError);
  }

  body(Widget app) {
    runApp(app);
  }

  // 通过接口上报异常
  void onError(Object error, StackTrace stack) {
    print('catch error: $error');
  }
}
