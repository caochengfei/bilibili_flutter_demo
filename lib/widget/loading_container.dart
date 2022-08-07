import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import '../util/rpx.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer(
      {Key? key, this.child, this.isLoading = true, this.cover = false})
      : super(key: key);
  final Widget? child;
  final bool isLoading;
  final bool cover;

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child ?? Container(),
          isLoading ? _loadingView : Container()
        ],
      );
    } else {
      return isLoading ? _loadingView : child ?? Container();
    }
  }

  Widget get _loadingView {
    return Center(
      child: Lottie.asset("assets/loading.json"),
    );
  }
}
