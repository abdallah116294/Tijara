import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';

import '../../../provider/cart_provider.dart';
import '../../../provider/produt_provider.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
      final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: kBottomNavigationBarHeight + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlesTextWidget(fontSize: 14,label: "Total(${cartProvider.getCartItems.length} products/${cartProvider.quantity()} items )" ),
                const SizedBox(
                  height: 2,
                ),
                 SubtitleTextWidget(
                  label: '${cartProvider.getTotial(productProvider: productProvider)}\$',
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {},
              child: const Text("Checkout"))
        ],
      ),
    );
  }
}
