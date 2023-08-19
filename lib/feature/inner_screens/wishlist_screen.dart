import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijara/feature/search/widget/product_card_widget.dart';
import 'package:tijara/provider/wishlist_provider.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/widgets/empty_bag.dart';
import '../../services/assets_manager.dart';
import '../../widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = '/WishlistScreen';
  WishlistScreen({super.key});
  AppMethods appMethods = AppMethods();
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
          
            body: EmptyBag(
              imagePath: AssetsManager.shoppinBasket,
              title: " Whoops",
              subtitle1:
                  'Your wishlist is empty is empty',
              subtitle2: 'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now ',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(
                  label:
                      "Wishlist (${wishlistProvider.getWishlistItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    appMethods.dailogAlert(
                        context: context,
                        fun: () {
                          wishlistProvider.clearLocalWishlist();
                        },
                        imagePathe: AssetsManager.warrning,
                        title: 'Remove items'
                        // isError: false,
                        // context: context,
                        // subtitle: "Remove items",
                        // fct: () {
                        //   wishlistProvider.clearLocalWishlist();
                        // }
                        );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: ((context, index) {
                return InkWell(
                  onTap: () {
                    debugPrint(wishlistProvider.getWishlistItems.values
                        .toList()[index]
                        .id
                        .toString());
                  },
                  child: ProductCard(
                    productID: wishlistProvider.getWishlistItems.values.toList()[index].productId,
                  ),
                );
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
