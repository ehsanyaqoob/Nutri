import 'package:nutri/models/product-model.dart';


class CategoryModel {
  final String icon;
  final String title;
  final List<ProductModel> products;
  final bool isOthers;

  CategoryModel({
    required this.icon,
    required this.title,
    required this.products,
    this.isOthers = false,
  });
}