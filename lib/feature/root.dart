import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:tijara/feature/cart/card_screen.dart';
import 'package:tijara/feature/home/screen/home_screen.dart';
import 'package:tijara/feature/home/screen/profile_screen.dart';
import 'package:tijara/feature/search/search_screen.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/provider/produt_provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const rootname = "RootScreen";
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  bool isloadingProds = true;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    CardScreen(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productprovider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    try {
      //productprovider.fetchProducts();
      Future.wait({productprovider.fetchProducts()});
      Future.wait({cartProvider.fetchCart()});
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        isloadingProds = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isloadingProds) {
      fetchFCT();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (int index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home),
              label: "Home"),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.search),
              icon: Icon(IconlyLight.search),
              label: "Search"),
          NavigationDestination(
              selectedIcon: const Icon(IconlyBold.bag2),
              icon: Badge(
                  label: Text("${cartProvider.getCartItems.length}"),
                  child: const Icon(IconlyLight.bag2)),
              label: "Cart"),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyLight.profile),
              label: "Profile"),
        ],
      ),
    );
  }
}
