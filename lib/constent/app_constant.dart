import '../models/category_model.dart';
import '../services/assets_manager.dart';

class AppConstant {
  static const String testImage =
      "https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png";
        static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
  static const List<String> bannersImage = [
    AssetsManager.banner1,
    AssetsManager.banner2
  ];
  static List<CategoryModel> catogiresList1 = [
    CategoryModel(
        id: AssetsManager.pc, image: AssetsManager.mobiles, name: "Laptops"),
    CategoryModel(
        id: AssetsManager.electorincs,
        image: AssetsManager.electorincs,
        name: "Electronics"),
    CategoryModel(
        id: AssetsManager.mobiles,
        image: AssetsManager.mobiles,
        name: "Phones"),
    CategoryModel(
        id: AssetsManager.watch, image: AssetsManager.watch, name: "Watches"),
  ];
  static List<CategoryModel> catogiresList2 = [
    CategoryModel(
        id: AssetsManager.fashion,
        image: AssetsManager.fashion,
        name: "clothes"),
    CategoryModel(
        id: AssetsManager.cosmetics,
        image: AssetsManager.cosmetics,
        name: "Cosmetics"),
    CategoryModel(
        id: AssetsManager.shose, image: AssetsManager.shose, name: "Shoes"),
    CategoryModel(
        id: AssetsManager.book, image: AssetsManager.mobiles, name: "Books"),
  ];
  //payment constent
  //https://accept.paymob.com/api/auth/tokens
  static const String baseApiPayment = "https://accept.paymob.com/api";
  static const String getAuthToken = "/auth/tokens";
  static const String paymentAPIkey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RneE9UazVMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMTVYRjdYd0ItUElrQWZkUkZOX1FvSTZCZmJLZVBDaHpaUWI5R3pXbG1TaUxXUzRIVlhfbFVSMGlMcGIwUHA3bG1xejB3NWxIUFBwNFE5cDh4a0U0anc=';
  static const String getOrderId = "/ecommerce/orders";
  static const String paymentKeyRequeset = "/acceptance/payment_keys";
  static const String getRefCode = "/acceptance/payments/pay";
  static String paymentFirstToken = "";
  static String paymentOrderId = "";
  static String paymentIntegrationCardId = "4115532";
  static String paymentIntegrationKisokId = "4120104";
  static String finalToken = " ";
  static String refCode = "";
   static String visaUrl =
      'https://accept.paymob.com/api/acceptance/iframes/782498?payment_token=ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hOVFUwTmpBd0xDSmhiVzkxYm5SZlkyVnVkSE1pT2pFd01Dd2lZM1Z5Y21WdVkza2lPaUpGUjFBaUxDSnBiblJsWjNKaGRHbHZibDlwWkNJNk5ERXhOVFV6TWl3aWIzSmtaWEpmYVdRaU9qRTBOalEwTlRjeE9Td2lZbWxzYkdsdVoxOWtZWFJoSWpwN0ltWnBjbk4wWDI1aGJXVWlPaUpEYkdsbVptOXlaQ0lzSW14aGMzUmZibUZ0WlNJNklrNXBZMjlzWVhNaUxDSnpkSEpsWlhRaU9pSkZkR2hoYmlCTVlXNWtJaXdpWW5WcGJHUnBibWNpT2lJNE1ESTRJaXdpWm14dmIzSWlPaUkwTWlJc0ltRndZWEowYldWdWRDSTZJamd3TXlJc0ltTnBkSGtpT2lKS1lYTnJiMnh6YTJsaWRYSm5hQ0lzSW5OMFlYUmxJam9pVlhSaGFDSXNJbU52ZFc1MGNua2lPaUpEVWlJc0ltVnRZV2xzSWpvaVkyeGhkV1JsZEhSbE1EbEFaWGhoTG1OdmJTSXNJbkJvYjI1bFgyNTFiV0psY2lJNklpczROaWc0S1RreE16VXlNVEEwT0RjaUxDSndiM04wWVd4ZlkyOWtaU0k2SWpBeE9EazRJaXdpWlhoMGNtRmZaR1Z6WTNKcGNIUnBiMjRpT2lKT1FTSjlMQ0pzYjJOclgyOXlaR1Z5WDNkb1pXNWZjR0ZwWkNJNlptRnNjMlVzSW1WNGRISmhJanA3ZlN3aWMybHVaMnhsWDNCaGVXMWxiblJmWVhSMFpXMXdkQ0k2Wm1Gc2MyVXNJbVY0Y0NJNk1UWTVNekl4TmpFNU15d2ljRzFyWDJsd0lqb2lNVFUwTGpFNE1pNDJPUzR5TlRJaWZRLmhuUXVhUF9wNkx6NDktZ0NhZVlTdkdpeWtnd1M4eTBUZDJIWUx4THhudi1keTlkQy0tQ1lqenZVOGhoMXFEblNlbEJFTl9xZXUtRURBQTd0NDNsRjdR';
   static String visaUrl2 =
      '$baseApiPayment/acceptance/iframes/782498?payment_token=$finalToken';    
}
