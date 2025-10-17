import 'package:nutri/constants/export.dart';
import 'package:nutri/models/order-model.dart';
import 'package:nutri/models/product-model.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:get_storage/get_storage.dart';

// class CartItem {
//   final ProductModel product;
//   final int quantity;
//   final int? selectedColorIndex;
//   final double totalPrice;

//   CartItem({
//     required this.product,
//     required this.quantity,
//     this.selectedColorIndex,
//   }) : totalPrice = (double.tryParse(product.price.replaceAll('\$', '')) ?? 0) * quantity;

//   CartItem copyWith({
//     int? quantity,
//     int? selectedColorIndex,
//   }) {
//     return CartItem(
//       product: product,
//       quantity: quantity ?? this.quantity,
//       selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'product': product.toJson(),
//       'quantity': quantity,
//       'selectedColorIndex': selectedColorIndex,
//       'totalPrice': totalPrice,
//     };
//   }

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       product: ProductModel.fromJson(json['product']),
//       quantity: json['quantity'],
//       selectedColorIndex: json['selectedColorIndex'],
//     );
//   }
// }

class ProductController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var selectedColorIndex = Rx<int?>(null);
  var quantity = 1.obs;
  
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();
  }

  void _loadCartFromStorage() {
    try {
      final cartData = _storage.read<List>('cartItems');
      if (cartData != null) {
        cartItems.value = cartData.map((item) => CartItem.fromJson(item)).toList();
        print("🛒 Loaded ${cartItems.length} items from storage");
      }
    } catch (e) {
      print("❌ Error loading cart: $e");
    }
  }

  void _saveCartToStorage() {
    try {
      final cartData = cartItems.map((item) => item.toJson()).toList();
      _storage.write('cartItems', cartData);
    } catch (e) {
      print("❌ Error saving cart: $e");
    }
  }

  void resetSelection() {
    selectedColorIndex.value = null;
    quantity.value = 1;
  }

  void setSelectedColor(int index) {
    selectedColorIndex.value = index;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart(ProductModel product) {
    if (selectedColorIndex.value == null) {
      AppToast.info('Please select a color before adding to cart');
      return;
    }

    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id && 
                item.selectedColorIndex == selectedColorIndex.value
    );

    if (existingItemIndex != -1) {
      final existingItem = cartItems[existingItemIndex];
      cartItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity.value
      );
      AppToast.info('Quantity updated in cart');
    } else {
      cartItems.add(CartItem(
        product: product,
        quantity: quantity.value,
        selectedColorIndex: selectedColorIndex.value,
      ));
      AppToast.info('Added to cart successfully');
    }

    _saveCartToStorage();
    resetSelection();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    AppToast.info('Item removed from cart');
    _saveCartToStorage();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(item);
      return;
    }

    final index = cartItems.indexOf(item);
    if (index != -1) {
      cartItems[index] = item.copyWith(quantity: newQuantity);
      _saveCartToStorage();
    }
  }

  void clearCart() {
    cartItems.clear();
    _saveCartToStorage();
    AppToast.info('Cart cleared');
  }

  double get totalCartValue {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItemsCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  bool isProductInCart(ProductModel product) {
    return cartItems.any((item) => item.product.id == product.id);
  }
}