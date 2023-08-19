import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:tijara/feature/cart/widgets/quantity_bottom_sheet_widget.dart';
import 'package:tijara/models/cart_model.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';

import '../../../provider/produt_provider.dart';
import '../../../widgets/heart_button.dart';

class CartWidget extends StatelessWidget {
  CartWidget({super.key});
  AppMethods appmethods = AppMethods();

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct =
        productProvider.findById(cartModelProvider.productId.toString());
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        height: size.height * 0.2,
                        width: size.width * 0.4,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: size.width * 0.6,
                                  child: TitlesTextWidget(
                                    label: getCurrentProduct.productTitle,
                                    maxLines: 2,
                                  )),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await appmethods.dailogAlert(
                                            context: context,
                                            imagePathe: AssetsManager.warrning,
                                            title:
                                                "Delete${" ${getCurrentProduct.productTitle}"}",
                                            fun: () async{
                                             try {
                                        await cartProvider
                                            .removeCartItemFromFirebase(
                                          cartId: cartModelProvider.cartId,
                                          productId: getCurrentProduct.productId,
                                          qty: cartModelProvider.quantity,
                                        );
                                      } catch (error) {
                                        log(error.toString());
                                      }
                                              Navigator.pop(context);
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      )),
                                  HeartButtonWidget(
                                    productId: getCurrentProduct.productId,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SubtitleTextWidget(
                                label: '${getCurrentProduct.productPrice}\$',
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.blue, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                icon: const Icon(IconlyLight.arrowDown2),
                                label:
                                    Text("qty:${cartModelProvider.quantity}"),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16))),
                                      context: context,
                                      builder: (context) {
                                        return QuantityBottomSheet(
                                          cartModel: cartModelProvider,
                                        );
                                      });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
