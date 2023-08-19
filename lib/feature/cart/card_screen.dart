import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/feature/cart/widgets/bottom_checkout_widget.dart';
import 'package:tijara/feature/cart/widgets/cart_widget.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:tijara/widgets/empty_bag.dart';

import '../../widgets/app_bar_title_widget.dart';

class CardScreen extends StatelessWidget {
  CardScreen({super.key});
  bool isEmpty = false;
   AppMethods appMethods=AppMethods();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBag(
                imagePath: AssetsManager.shoppinBasket,
                title: "Whoops",
                subtitle1: "Your Cart empty ",
                subtitle2:
                    "Looks like you didn't add anything yet to your cart \n go ahead and start shopping now  "))
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,

              leading: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.purple,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    IconlyLight.bag2,
                    size: 30,
                  ),
                ),
              ),
              // leading:const Icon(Icons.shopping_cart,size: 40,color: Colors.grey,),
              title: AppBarNameTitle(
                title: 'Cart(${cartProvider.getCartItems.length})',
              ),
              actions: [
                IconButton(
                    onPressed: () {
                     
                      appMethods.dailogAlert(
                          context: context,
                          imagePathe: AssetsManager.warrning,
                          title: "Delete",
                          fun: () async{
                           await cartProvider.clearCartFromFirebase();
                          });
                    },
                    icon: const Icon(Icons.delete_forever_rounded))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.getCartItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItems.values
                                .toList()
                                .reversed
                                .toList()[index],
                            child:  CartWidget());
                      }
                      ),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                )
              ],
            ),
            bottomSheet: const CartBottomCheckout(),
          );
  }
}
