import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tijara/constent/theme_data.dart';
import 'package:tijara/feature/auth/screens/forget_passsword_screen.dart';
import 'package:tijara/feature/auth/screens/login_screen.dart';
import 'package:tijara/feature/auth/screens/register_screen.dart';
import 'package:tijara/feature/inner_screens/oreder/order_scree.dart';
import 'package:tijara/feature/inner_screens/product_deteails_screen.dart';
import 'package:tijara/feature/inner_screens/view_recently_screen.dart';
import 'package:tijara/feature/inner_screens/wishlist_screen.dart';
import 'package:tijara/feature/root.dart';
import 'package:tijara/feature/search/search_screen.dart';
import 'package:tijara/provider/cart_provider.dart';
import 'package:tijara/provider/produt_provider.dart';
import 'package:tijara/provider/theme_provider.dart';
import 'package:tijara/provider/user_provider.dart';
import 'package:tijara/provider/viewed_pro_provider.dart';
import 'package:tijara/provider/wishlist_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProductProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
                 ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Style.hemeData(
                    isDark: themeProvider.getIsDarkTheme, context: context),
                home: const RootScreen(),
                // onGenerateRoute:Routes.onGenerateRoute,
                routes: {
                  ProductDetailsScreen.routname: (context) =>
                      const ProductDetailsScreen(),
                  WishlistScreen.routName: (context) => WishlistScreen(),
                  ViewRecentlyScrenn.routName: (context) =>
                      const ViewRecentlyScrenn(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routName: (context) => const SearchScreen(),
                  RootScreen.rootname:(context)=>const RootScreen()
                },
              );
            }),
          );
        }
        
  }

