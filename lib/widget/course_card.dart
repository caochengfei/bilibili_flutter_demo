import 'package:bilibili_demo/model/profile_mo.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/rpx.dart';

class CourseCard extends StatelessWidget {
  final List<Course> courseList;
  const CourseCard({Key? key, required this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.px, right: 5.px, top: 15.px),
      child: Column(
        children: [
          _buildTitle(),
          ..._buildCardList(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.px),
      child: Row(
        children: [
          Text(
            '职场进阶',
            style: TextStyle(fontSize: 15.px, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10.px),
          Text(
            '带你突破技术瓶颈',
            style: TextStyle(fontSize: 12.px, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    var courseGroup = Map();
    //将数据分组
    courseList.forEach((model) {
      if (!courseGroup.containsKey(model.group)) {
        courseGroup[model.group] = [];
      }
      List list = courseGroup[model.group];
      list.add(model);
    });
    return courseGroup.entries.map((e) {
      List list = e.value;
      // 根据卡片数量计算出每个卡片宽度
      var width =
          (MediaQuery.of(context).size.width - 20.px - (list.length - 1) * 5) /
              list.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...list.map((model) => _buildCard(model, width, height)).toList()
        ],
      );
    });
  }

  _buildCard(Course model, double width, double height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5.px, bottom: 7.px),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.px),
          child: cachedImage(model.cover!, width: width, height: height),
        ),
      ),
    );
  }
}
