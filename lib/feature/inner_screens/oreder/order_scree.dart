import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/empty_bag.dart';
import '../../../provider/cart_provider.dart';
import '../../../services/assets_manager.dart';
import '../../../widgets/title_text.dart';
import 'order_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
final cartProvider = Provider.of<CartProvider>(context);
    return  cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBag(
                imagePath: AssetsManager.shoppinBasket,
                title: "Whoops",
                subtitle1: "Your Cart empty ",
                subtitle2:
                    "Looks like you didn't add anything yet to your cart \n go ahead and start shopping now  "))
        : Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: isEmptyOrders
            ? EmptyBag(
                imagePath: AssetsManager.shoppingCart,
                title: "No orders has been placed yet",
                subtitle1: "",
                subtitle2: "Shop now")
            : ListView.separated(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.getCartItems.values
                                .toList()
                                .reversed
                                .toList()[index],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                      child: OrdersWidgetFree(),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
/*
ListView.builder(
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
*/