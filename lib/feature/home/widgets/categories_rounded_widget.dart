import 'package:flutter/material.dart';
import 'package:tijara/feature/search/search_screen.dart';
import 'package:tijara/widgets/subtitle.dart';
class CategoriesRounded extends StatelessWidget {
  const CategoriesRounded({super.key, required this.image, required this.name});
  final String image, name;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context,SearchScreen.routName,arguments:name );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 19,),
          SubtitleTextWidget(label: name,fontWeight: FontWeight.bold,fontSize: 14,)
        ],
      ),
    );
  }
}
