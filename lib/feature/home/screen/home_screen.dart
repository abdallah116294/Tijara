import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/widgets/title_text.dart';

import '../../../constent/app_constant.dart';
import '../../../widgets/app_bar_title_widget.dart';
import '../widgets/categories_rounded_widget.dart';
import '../widgets/latest_arrival_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // final themeprovider = Provider.of<ThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            title: 'Tijara',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .24,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: Swiper(
                      itemCount: 2,
                      duration: 2000,
                      autoplay: true,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppConstant.bannersImage[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.red, activeColor: Colors.blue)),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                //   ()
                const TitlesTextWidget(
                  label: "Lastest Arrival",
                  fontSize: 22,
                ),
                const Divider(),
                SizedBox(
                  height: size.height * .2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return LatestArrivalWidget(
                       productId: productProvider.getProduct[index].productId,
                      );
                    },
                    itemCount: productProvider.getProduct.length,
                  ),
                ),
              
                const Divider(),
                const TitlesTextWidget(
                  label: "Categories",
                  fontSize: 22,
                ),
                const Divider(),
                GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: List.generate(AppConstant.catogiresList1.length,
                        (index) {
                      return CategoriesRounded(
                          image: AppConstant.catogiresList1[index].image,
                          name: AppConstant.catogiresList1[index].name);
                    })),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: List.generate(AppConstant.catogiresList2.length,
                        (index) {
                      return CategoriesRounded(
                          image: AppConstant.catogiresList2[index].image,
                          name: AppConstant.catogiresList2[index].name);
                    })),
              ],
            ),
          ),
        ));
  }
}
