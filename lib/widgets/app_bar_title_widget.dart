import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/widgets/title_text.dart';

class AppBarNameTitle extends StatelessWidget {
   AppBarNameTitle({super.key,required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.purple,
      child: TitlesTextWidget(
        label: title,
      ),
    );
  }
}
