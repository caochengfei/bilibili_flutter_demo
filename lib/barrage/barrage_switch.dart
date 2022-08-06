import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BarrageSwitch extends StatefulWidget {
  const BarrageSwitch(
      {Key? key,
      this.initSwitch = true,
      this.inoutShowing = false,
      required this.onShowInput,
      required this.onBarrageSwitch})
      : super(key: key);
  // 初始状态是否展开
  final bool initSwitch;
  // 是否为输入中
  final bool inoutShowing;
  // 输入框切换回调
  final VoidCallback onShowInput;
  // 展开与伸缩状态切换回调
  final ValueChanged<bool> onBarrageSwitch;

  @override
  State<BarrageSwitch> createState() => _BarrageSwitchState();
}

class _BarrageSwitchState extends State<BarrageSwitch> {
  bool _barrageSwitch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _barrageSwitch = widget.initSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(right: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [_buildText(), _buildIcon()],
      ),
    );
  }

  _buildText() {
    var text = widget.inoutShowing ? '弹幕输入中' : '请输入弹幕';
    return _barrageSwitch
        ? InkWell(
            onTap: () {
              widget.onShowInput();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          )
        : Container();
  }

  _buildIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          _barrageSwitch = !_barrageSwitch;
        });
        widget.onBarrageSwitch(_barrageSwitch);
      },
      child: Icon(
        Icons.live_tv_rounded,
        color: _barrageSwitch ? primary : Colors.grey,
      ),
    );
  }
}
