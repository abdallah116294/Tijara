import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tijara/models/product_model.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> cartItems = {};
  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

//firebase
  final userDB = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  AppMethods appMethods = AppMethods();

  Future<void> addToCartFirebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = auth.currentUser;
    if (user == null) {
      appMethods.dailogAlert(
          context: context,
          imagePathe: AssetsManager.warrning,
          title: "You don't have access",
          fun: () {
            Navigator.pop(context);
          });
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      userDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    User? user = auth.currentUser;
    if (user == null) {
      log("the function has been called and the user is null");
      cartItems.clear();
      return;
    }
    try {
      final userDoc = await userDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        return;
      }
      final leng = userDoc.get("userCart").length;
      for (int index = 0; index < leng; index++) {
        cartItems.putIfAbsent(
          userDoc.get('userCart')[index]['productId'],
          () => CartModel(
            cartId: userDoc.get('userCart')[index]['cartId'],
            productId: userDoc.get('userCart')[index]['productId'],
            quantity: userDoc.get('userCart')[index]['quantity'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearCartFromFirebase() async {
    User? user = auth.currentUser;
    try {
      await userDB.doc(user!.uid).update({"userCart": []});
      cartItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeCartItemFromFirebase(
      {required String cartId,
      required String productId,
      required int qty}) async {
    User? user = auth.currentUser;
    try {
      await userDB.doc(user!.uid).update({
        "userCart": FieldValue.arrayRemove([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      cartItems.remove(productId);
      await fetchCart();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  bool isProductIncart({required String productId}) {
    return cartItems.containsKey(productId);
  }

  void addproductTocart({required String productId}) {
    cartItems.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
    notifyListeners();
  }

  void updateQuantit({required String productId, required int quantity}) {
    cartItems.update(
        productId,
        (item) => CartModel(
            productId: productId, quantity: quantity, cartId: item.cartId));
    notifyListeners();
  }

  double getTotial({required ProductProvider productProvider}) {
    double total = 0.0;
    cartItems.forEach((key, value) {
      final ProductModel? getcurrentProduct =
          productProvider.findById(value.productId);
      if (getcurrentProduct == null) {
        return;
      } else {
        total += double.parse(getcurrentProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  void reomveOneItem({required String productId}) {
    cartItems.remove(productId);
    notifyListeners();
  }

  void clearLocatCart() {
    cartItems.clear();
    notifyListeners();
  }

  int quantity() {
    int total = 0;
    cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }
}
//d8dc4481-739e-4cf9-8c56-c3aef3e671dc