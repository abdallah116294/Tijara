import 'package:flutter/material.dart';
import 'package:tijara/constent/app_color.dart';

class Style {
  static ThemeData hemeData(
      {required bool isDark, required BuildContext context}) {
    return ThemeData(
        scaffoldBackgroundColor:
            isDark ? AppColor.darkSCaffoldColor : AppColor.lightScaffoldBColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
        appBarTheme: AppBarTheme(
            iconTheme:
                IconThemeData(color: isDark ? Colors.white : Colors.black),
            backgroundColor: isDark
                ? AppColor.darkSCaffoldColor
                : AppColor.lightScaffoldBColor,
            elevation: 0.0,
            titleTextStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
            focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: isDark ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
                  focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
          filled: true,
          // contentPadding: const EdgeInsets.only(top: 10),
        ));
  }
}
