import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/feature/search/widget/product_card_widget.dart';
import 'package:tijara/models/product_model.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/widgets/title_text.dart';

import '../../widgets/app_bar_title_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routName = "SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProduct
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.purple,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  IconlyLight.search,
                  size: 30,
                ),
              ),
            ),
            // leading:const Icon(Icons.shopping_cart,size: 40,color: Colors.grey,),
            title: AppBarNameTitle(title: passedCategory ?? 'Search'),
          ),
          body:
              productList.isEmpty
                  ? const Center(
                      child: TitlesTextWidget(
                      label: "No product found",
                      fontSize: 40,
                    ))
                  :
              StreamBuilder<List<ProductModel>>(
                  stream: productProvider.fetchproductstStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                            TitlesTextWidget(label: snapshot.error.toString()),
                      );
                    } else if (snapshot.data == null) {
                    return  const Center(
                          child: TitlesTextWidget(
                        label: "No product found",
                        fontSize: 40,
                      ));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            onSubmitted: (value) {
                              setState(() {
                                productListSearch = productProvider.searchQuery(
                                    searchText: searchController.text,
                                    passedList: productList);
                              });
                              debugPrint(searchController.text);
                            },
                            onChanged: (value) {},
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      searchController.clear();
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ))),
                            // decoration: Theme.of(context).inputDecorationTheme,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          if (searchController.text.isNotEmpty &&
                              productListSearch.isEmpty) ...[
                            const TitlesTextWidget(
                              label: "No reslut found",
                              fontSize: 40,
                            )
                          ],
                          Expanded(
                            child: DynamicHeightGridView(
                                builder: (BuildContext context, int index) {
                                  return ChangeNotifierProvider.value(
                                    value: productList[index],
                                    child: ProductCard(
                                      productID: searchController
                                              .text.isNotEmpty
                                          ? productListSearch[index].productId
                                          : productList[index].productId,
                                    ),
                                  );
                                },
                                crossAxisCount: 2,
                                itemCount: searchController.text.isNotEmpty
                                    ? productListSearch.length
                                    : productList
                                        .length //ProductModel.localProds.length,
                                ),
                          )
                        ],
                      ),
                    );
                  })),
    );
  }
}
