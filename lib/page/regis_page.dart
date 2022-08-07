import 'package:bilibili_demo/http/core/hi_error.dart';
import 'package:bilibili_demo/http/core/hi_net.dart';
import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/string_util.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/widget/appbar.dart';
import 'package:bilibili_demo/widget/login_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widget/login_input.dart';
import '../widget/login_effect.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

class CFRegisPage extends StatefulWidget {
  const CFRegisPage({Key? key}) : super(key: key);

  @override
  State<CFRegisPage> createState() => _CFRegisPageState();
}

class _CFRegisPageState extends State<CFRegisPage> {
  bool _protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String imooocId = "5434499";
  String orderId = "7748";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        context.read<ThemeProvider>().setTheme(ThemeMode.light);
        HiNavigator.getInstantce().onJumpTo(RouteStatus.login);
      }),
      body: Container(
        child: ListView(
          //自适键盘
          children: [
            CFLoginEffect(
              protect: _protect,
            ),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  _protect = focus;
                });
              },
            ),
            LoginInput(
              title: "确认密码",
              hint: "请再次输入密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  _protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.px, left: 20.px, right: 20.px),
              child: LoginButton(
                title: "注册",
                enable: loginEnable,
                onPressed: () {
                  checkParams();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imooocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result =
          await LoginDao.regis(userName!, password!, imooocId, orderId);
      print("regins: - $result");
      if (result['code'] == 0) {
        showToast("注册成功");
        HiNavigator.getInstantce().onJumpTo(RouteStatus.login);
      } else {
        print(result['message']);
      }
    } on NeedAuth catch (e) {
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      showWaarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId.length != 4) {
      tips = "请输入订单号后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
