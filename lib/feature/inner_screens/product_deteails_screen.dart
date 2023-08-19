import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/provider/wishlist_provider.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';
import '../../services/app_methods.dart';
import '../../services/assets_manager.dart';
import '../../widgets/app_bar_title_widget.dart';
import '../../widgets/heart_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.productId});
  final String? productId;
  static const routname = "ProductDetailsScreen";
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
   AppMethods appMethods=AppMethods();
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments;
    final getCurrentProduct = productProvider.findById(productId.toString());
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrowLeft2),
        ),
        centerTitle: true,
        title: AppBarNameTitle(title: "TiJara"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FancyShimmerImage(
            imageUrl: getCurrentProduct!.productImage,
            height: size.height * .38,
            width: double.infinity,
            errorWidget: Container(),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TitlesTextWidget(
                //   label: "product name",
                //   fontSize: 22,
                //   maxLines: 2,
                // ),
                Flexible(
                    child: Text(
                  getCurrentProduct.productTitle,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )),
                SubtitleTextWidget(
                  label: "${getCurrentProduct.productPrice}\$",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                HeartButtonWidget(
                                productId: getCurrentProduct.productId,
                                color: Colors.blue.shade300
                              ),

                const Spacer(),
                Container(
                  width: size.width * .6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // : Colors.blue,
                      padding: const EdgeInsets.all(5),
                      backgroundColor: Colors.lightBlueAccent.shade100,
                    ),
                    onPressed: () async{
                      // if (cartProvider.isProductIncart(
                      //     productId: getCurrentProduct.productId)) {
                      //   return;
                      // }
                      // cartProvider.addproductTocart(
                      //     productId: getCurrentProduct.productId);
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
                    },
                    icon: Icon(cartProvider.isProductIncart(
                            productId: getCurrentProduct.productId)
                        ? Icons.check
                        : Icons.shopping_cart_rounded),
                    label: Text(
                      cartProvider.isProductIncart(
                              productId: getCurrentProduct.productId)
                          ? "done"
                          : "Add to cart",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitlesTextWidget(label: "Details"),
                SubtitleTextWidget(
                  label: getCurrentProduct.prodcutCategory,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // TitlesTextWidget(label: "descriptions"*10)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getCurrentProduct.productDescription,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
