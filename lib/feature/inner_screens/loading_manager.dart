import 'package:flutter/material.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager(
      {super.key, required this.isloadinge, required this.child});
  final bool isloadinge;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isloadinge) ...[
          Container(color: Colors.black.withOpacity(.7),),
          const Center(
            child: CircularProgressIndicator(),
          )
        ]
      ],
    );
  }
}
