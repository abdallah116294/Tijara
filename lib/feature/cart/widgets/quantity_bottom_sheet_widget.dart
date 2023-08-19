import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijara/widgets/subtitle.dart';

import '../../../models/cart_model.dart';
import '../../../provider/cart_provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
      final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: InkWell(
                          onTap: () {
                            cartProvider.updateQuantit(productId:cartModel.productId ,quantity: index+1);
                            Navigator.pop(context);
                            debugPrint(index.toString());
                          },
                          child: SubtitleTextWidget(label: "${index+1}"))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
