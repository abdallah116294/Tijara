import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/provider/viewed_pro_provider.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:tijara/widgets/empty_bag.dart';

import '../../widgets/app_bar_title_widget.dart';
import '../search/widget/product_card_widget.dart';

class ViewRecentlyScrenn extends StatelessWidget {
  const ViewRecentlyScrenn({super.key});
  static const routName = "ViewRecentlyScrenn";
  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProductProvider>(context);

    return  Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                      size: 30,
                    ),
                  ),
                ),
              ),
              // leading:const Icon(Icons.shopping_cart,size: 40,color: Colors.grey,),
              title: AppBarNameTitle(
                title: '${viewedProvider.getViewedProItems.length}',
              ),
            ),
            body: viewedProvider.getViewedProItems.isEmpty?EmptyBag(imagePath: AssetsManager.shoppinBasket, title: "Whoops", subtitle1: "Your view recently is empty", subtitle2: "Looks like you didn't add anything yet to your cart \ngo ahead and start shopping now") :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: DynamicHeightGridView(
                      builder: (BuildContext context, int index) {
                        return ProductCard(
                          productID: viewedProvider.getViewedProItems.values
                              .toList()[index]
                              .produtId,
                        );
                      },
                      crossAxisCount: 2,
                      itemCount: viewedProvider.getViewedProItems.length,
                    ),
                  )
                ],
              ),
            ));
  }
}
/*
viewedProvider.getviewedProdItems.values
                        .toList()[index]
                        .productId
*/