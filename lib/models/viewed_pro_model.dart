import 'package:flutter/material.dart';

class ViewedProModel with ChangeNotifier {
  final String id;
  final String produtId;
  ViewedProModel({
    required this.id,
    required this.produtId,
  });
}
