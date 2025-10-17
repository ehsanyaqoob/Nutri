import 'dart:convert';
import 'package:nutri/app-state/app-state.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/models/product-model.dart';
import 'package:get_storage/get_storage.dart';

class FavouritesController extends BaseController {
  final RxList<ProductModel> _favourites = <ProductModel>[].obs;
  final GetStorage _storage = GetStorage();

  static const String _favouritesKey = 'favourites_data';

  List<ProductModel> get favourites => _favourites.toList();

  @override
  void onInit() {
    super.onInit();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    await runAsyncOperation(() async {
      final favouritesData = _storage.read(_favouritesKey);
      if (favouritesData != null && favouritesData.isNotEmpty) {
        final List<dynamic> decoded = json.decode(favouritesData);
        _favourites.assignAll(
          decoded.map((item) => ProductModel.fromJson(item)).toList(),
        );
      }
    });
  }

  Future<void> persistFavourites() async {
    try {
      final favouritesJson = json.encode(
        _favourites.map((e) => e.toJson()).toList(),
      );
      await _storage.write(_favouritesKey, favouritesJson);
      debugPrint('✅ Favourites persisted successfully');
    } catch (e) {
      debugPrint('❌ Error persisting favourites: $e');
    }
  }

  void toggleFavourite(ProductModel product, bool isLiked) {
    if (isLiked) {
      _favourites.add(product);
    } else {
      _favourites.removeWhere((item) => item.title == product.title);
    }
    persistFavourites();
  }

  bool isFavourite(ProductModel product) {
    return _favourites.any((item) => item.title == product.title);
  }

  // Lifecycle handlers
  void onAppResumed() => _loadFavourites();
  void onAppInactive() => persistFavourites();
  void onAppPaused() => persistFavourites();
  void onAppDetached() => persistFavourites();
}
