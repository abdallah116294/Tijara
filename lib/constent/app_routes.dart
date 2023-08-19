// import 'package:flutter/material.dart';
// import 'package:tijara/feature/auth/screens/forget_passsword_screen.dart';
// import 'package:tijara/feature/auth/screens/login_screen.dart';
// import 'package:tijara/feature/auth/screens/register_screen.dart';
// import 'package:tijara/feature/inner_screens/oreder/order_scree.dart';
// import 'package:tijara/feature/inner_screens/product_deteails_screen.dart';
// import 'package:tijara/feature/inner_screens/wishlist_screen.dart';
// import 'package:tijara/feature/root.dart';
// import '../feature/inner_screens/view_recently_screen.dart';

// class AppRoutes {
//   static const initialRoute = '/';
//   static const productDetailsScreen = '/ProductDetailsScreen';
//   static const wishlistScreen = '/WishLlistScreen';
//   static const recentlyScreen = '/ViewRecentlyScrenn';
//   static const loginScreen = "/LoginScreen";
//   static const registerScreen = '/RegisterScreen';
//   static const orderScreen = '/OrdersScreenFree';
//   static const forgetPassword = '/ForgotPasswordScreen';
// }

// class Routes {
//   static Route? onGenerateRoute(RouteSettings routeSettings) {
//     final productId = routeSettings.arguments as String;
//     switch (routeSettings.name) {
//       case AppRoutes.initialRoute:
//         return MaterialPageRoute(builder: (context) => const RootScreen());
//       // case AppRoutes.productDetailsScreen:
//       //   return MaterialPageRoute(
//       //     builder: (context) => ProductDetailsScreen(productId: productId,),
//       //   );
//       case AppRoutes.wishlistScreen:
//         return MaterialPageRoute(builder: (context) => WishLlistScreen());
//       case AppRoutes.recentlyScreen:
//         return MaterialPageRoute(
//             builder: (context) => const ViewRecentlyScrenn());
//       case AppRoutes.loginScreen:
//         return MaterialPageRoute(builder: (context) => const LoginScreen());
//       case AppRoutes.registerScreen:
//         return MaterialPageRoute(builder: (context) => const RegisterScreen());
//       case AppRoutes.orderScreen:
//         return MaterialPageRoute(
//             builder: (context) => const OrdersScreenFree());
//       case AppRoutes.forgetPassword:
//         return MaterialPageRoute(
//             builder: (context) => const ForgotPasswordScreen());
//     }
//   }
// }
