import 'package:flutter/material.dart';

import '../widgets/subtitle.dart';

class AppMethods {
  Future<void> dailogAlert(
      {required BuildContext context,
      required String imagePathe,
      required String title,
      required Function fun}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                imagePathe,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              SubtitleTextWidget(label: title),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "cancel",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      )),
                  const SizedBox(height: 18),
                  TextButton(
                      onPressed: () {
                        fun();
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      )),
                ],
              )
            ]),
          );
        });
  }

  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function camerFun,
      required Function galeryFun,
      required Function removeFun}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Chose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        camerFun();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("Camera")),
                  TextButton.icon(
                      onPressed: () {
                        galeryFun();
                      },
                      icon: const Icon(Icons.file_open),
                      label: const Text("Galery")),
                  TextButton.icon(
                      onPressed: () {
                        removeFun();
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text("remove"))
                ],
              ),
            ),
          );
        });
  }
}
