import 'package:bilibili_demo/model/profile_mo.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:bilibili_demo/widget/hi_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// 增值服务
class BenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;
  const BenefitCard({Key? key, required this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          buildBenefit(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '增值服务',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            '购买后再次打开',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  _buildCard(BuildContext context, Benefit model, double width) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrange),
            child: Stack(
              children: [
                Positioned.fill(child: HiBlur()),
                Positioned.fill(
                    child: Center(
                  child: Text(
                    model.name!,
                    style: TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildBenefit(BuildContext context) {
    if (benefitList.isEmpty) return Container();
    // 根据卡片数量计算出每个卡片宽度
    var width = (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;
    return Row(
      children: [
        ...benefitList.map((e) => _buildCard(context, e, width)).toList(),
      ],
    );
  }
}
