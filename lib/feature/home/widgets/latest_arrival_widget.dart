import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/provider/wishlist_provider.dart';

import '../../../services/app_methods.dart';
import '../../../services/assets_manager.dart';
import '../../../widgets/heart_button.dart';
import '../../../widgets/subtitle.dart';
import '../../../widgets/title_text.dart';
import '../../inner_screens/product_deteails_screen.dart';

class LatestArrivalWidget extends StatelessWidget {
  LatestArrivalWidget({
    super.key,
    this.productId,
  });
  // String? image,title, price;
  String? productId;
  AppMethods appMethods=AppMethods();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final geCurrentProduct = productProvider.findById(productId.toString());
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    Size size = MediaQuery.of(context).size;
    return  geCurrentProduct!.productId.isEmpty?const SizedBox(): SizedBox(
      width: size.width * .6,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routname,
              arguments: geCurrentProduct.productId);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                      imageUrl: geCurrentProduct.productImage,
                      width: double.infinity,
                      height: size.height * .22)),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlesTextWidget(label: geCurrentProduct.productTitle),
                Row(
                  children: [
                      HeartButtonWidget(
                                productId: geCurrentProduct.productId,

                              ),

                    IconButton(
                        onPressed: () async{
                           if (cartProvider.isProductIncart(
                                productId: geCurrentProduct.productId)) {
                              return;
                            }
                            try {
                              await cartProvider.addToCartFirebase(
                                  productId: geCurrentProduct.productId,
                                  qty: int.parse(
                                      geCurrentProduct.productQuantity),
                                  context: context);
                            } catch (error) {
                              appMethods.dailogAlert(
                                  context: context,
                                  imagePathe: AssetsManager.warrning,
                                  title: error.toString(),
                                  fun: (){});
                            }
                        },
                        icon: Icon(
                          cartProvider.isProductIncart(
                                  productId: geCurrentProduct.productId)
                              ? Icons.check
                              : Icons.add_shopping_cart_rounded,
                          color: Colors.blue,
                        )),
                  ],
                ),
                FittedBox(
                  child: SubtitleTextWidget(
                    label: "${geCurrentProduct.productPrice}\$",
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
