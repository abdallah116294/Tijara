import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/viewed_pro_model.dart';

class ViewedProductProvider with ChangeNotifier {
  final Map<String, ViewedProModel> viewedListItem = {};
  Map<String, ViewedProModel> get getViewedProItems {
    return viewedListItem;
  }

  bool isProductInViewedList({required productId}) {
    return viewedListItem.containsKey(productId);
  }

  void addtoViewedProduct({required String productId}) {
    viewedListItem.putIfAbsent(productId,
        () => ViewedProModel(id: const Uuid().v4(), produtId: productId));
    notifyListeners();
  }
}
