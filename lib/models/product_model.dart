import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId,
      productPrice,
      productTitle,
      prodcutCategory,
      productDescription,
      productImage,
      productQuantity;
  final Timestamp? createdAt;
  ProductModel(
      {required this.productId,
      required this.productPrice,
      required this.productTitle,
      required this.prodcutCategory,
      required this.productDescription,
      required this.productImage,
      required this.productQuantity,
       this.createdAt
      });
  factory ProductModel.fromFirsestore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map<String, dynamic>;
    return ProductModel(
        productId: data["productId"],
        productPrice: data["productPrice"],
        productTitle: data["productTitle"],
        prodcutCategory: data["productCategory"],
        productDescription: data["productDescription"],
        productImage: data["productImage"],
        productQuantity: data["productQuantity"],
        createdAt: data["createdAt"]
        );
  }
}
