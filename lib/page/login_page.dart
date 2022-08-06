import 'dart:ffi';

import 'package:bilibili_demo/http/dao/login_dao.dart';
import 'package:bilibili_demo/navigator/hi_navigator.dart';
import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/toast.dart';
import 'package:bilibili_demo/widget/appbar.dart';
import 'package:bilibili_demo/widget/login_button.dart';
import 'package:bilibili_demo/widget/login_effect.dart';
import 'package:bilibili_demo/widget/login_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/string_util.dart';
import '../http/core/hi_error.dart';
import 'package:provider/provider.dart';

class CFLoginPage extends StatefulWidget {
  const CFLoginPage({Key? key}) : super(key: key);

  @override
  State<CFLoginPage> createState() => _CFLoginPageState();
}

class _CFLoginPageState extends State<CFLoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {
        context.read<ThemeProvider>().setTheme(ThemeMode.dark);
        HiNavigator.getInstantce().onJumpTo(RouteStatus.regis);
      }),
      body: Container(
        child: ListView(
          children: [
            CFLoginEffect(protect: protect),
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
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                title: "登录",
                enable: loginEnable,
                onPressed: () {
                  send();
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
    if (isNotEmpty(userName) && isNotEmpty(password)) {
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
      var result = await LoginDao.login(userName!, password!);
      print("login: - $result");
      if (result['code'] == 0) {
        showToast("登录成功");
        HiNavigator.getInstantce().onJumpTo(RouteStatus.home);
      } else {
        print(result['message']);
      }
    } on NeedAuth catch (e) {
      showWaarnToast(e.message);
    } on HiNetError catch (e) {
      showWaarnToast(e.message);
    }
  }
}
