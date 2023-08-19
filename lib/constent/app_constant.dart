import '../models/category_model.dart';
import '../services/assets_manager.dart';

class AppConstant {
  static const String testImage =
      "https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png";
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
}
