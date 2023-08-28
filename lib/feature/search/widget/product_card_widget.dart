import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/provider/viewed_pro_provider.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';

import '../../../provider/wishlist_provider.dart';
import '../../../widgets/heart_button.dart';
import '../../inner_screens/product_deteails_screen.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, this.productID});
  final String? productID;
  // final String? image, title, price;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  AppMethods appMethods = AppMethods();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    //final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct =
        productProvider.findById(widget.productID.toString());
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final viewedproProvider = Provider.of<ViewedProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                viewedproProvider.addtoViewedProduct(
                    productId: getCurrentProduct.productId);
                Navigator.pushNamed(context, ProductDetailsScreen.routname,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                          imageUrl: getCurrentProduct.productImage,
                          width: double.infinity,
                          height: size.height * .22)),
                  Row(
                    children: [
                      Flexible(
                          flex: 5,
                          child: TitlesTextWidget(
                              label: getCurrentProduct.productTitle * 10)),
                      Flexible(
                        child: HeartButtonWidget(
                          productId: getCurrentProduct.productId,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: SubtitleTextWidget(
                          label: "${getCurrentProduct.productPrice}\$",
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      Flexible(
                          child: Material(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          splashColor: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            if (cartProvider.isProductIncart(
                                productId: getCurrentProduct.productId)) {
                              return;
                            }
                            try {
                              await cartProvider.addToCartFirebase(
                                  productId: getCurrentProduct.productId,
                                  qty: int.parse(
                                      getCurrentProduct.productQuantity),
                                  context: context);
                            } catch (error) {
                              appMethods.dailogAlert(
                                  context: context,
                                  imagePathe: AssetsManager.warrning,
                                  title: error.toString(),
                                  fun: (){});
                            }
                            // cartProvider.addproductTocart(
                            //   productId: getCurrentProduct.productId,
                            // );
                          },
                          child: Icon(
                            cartProvider.isProductIncart(
                                    productId: getCurrentProduct.productId)
                                ? Icons.check
                                : Icons.add_shopping_cart_rounded,
                            size: 30,
                          ),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
  }
}
