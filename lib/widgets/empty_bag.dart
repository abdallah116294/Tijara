import 'package:flutter/material.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';


class EmptyBag extends StatelessWidget {
   EmptyBag({super.key,required this.imagePath,required this.title,required this.subtitle1,required this.subtitle2});
  String imagePath,title,subtitle1,subtitle2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * .35,
              width: double.infinity,
            ),
             TitlesTextWidget(
              label: title,
              fontSize: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
             SubtitleTextWidget(
              label: subtitle1,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleTextWidget(
                label:
                    subtitle2,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.all(20)),
                onPressed: () {},
                child: const Text(
                  "Shop now ",
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      ),
    );
  }
}
