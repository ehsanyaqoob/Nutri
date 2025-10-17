import 'package:nutri/models/product-model.dart';

class Order {
  final String orderNumber;
  final DateTime orderDate;
  final List<CartItem> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime estimatedDelivery;
  final List<OrderStatusUpdate> statusHistory;

  Order({
    required this.orderNumber,
    required this.orderDate,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.estimatedDelivery,
    required this.statusHistory,
  });

  // Convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'orderDate': orderDate.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'status': status.toString().split('.').last, // Store as string without enum prefix
      'estimatedDelivery': estimatedDelivery.toIso8601String(),
      'statusHistory': statusHistory.map((update) => update.toJson()).toList(),
    };
  }

  // Create Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'],
      orderDate: DateTime.parse(json['orderDate']),
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      status: _statusFromString(json['status']),
      estimatedDelivery: DateTime.parse(json['estimatedDelivery']),
      statusHistory: (json['statusHistory'] as List? ?? [])
          .map((update) => OrderStatusUpdate.fromJson(update))
          .toList(),
    );
  }

  // Convert string to OrderStatus
  static OrderStatus _statusFromString(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  // Helper method to create a new order with updated status
  Order copyWith({
    String? orderNumber,
    DateTime? orderDate,
    List<CartItem>? items,
    double? totalAmount,
    String? shippingAddress,
    String? paymentMethod,
    OrderStatus? status,
    DateTime? estimatedDelivery,
    List<OrderStatusUpdate>? statusHistory,
  }) {
    return Order(
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }

  // Helper method to add a new status update
  Order addStatusUpdate(OrderStatus newStatus, {String? note}) {
    final newUpdate = OrderStatusUpdate(
      status: newStatus,
      timestamp: DateTime.now(),
      note: note,
    );
    
    final updatedHistory = List<OrderStatusUpdate>.from(statusHistory)
      ..add(newUpdate);
    
    return copyWith(
      status: newStatus,
      statusHistory: updatedHistory,
    );
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String? note;

  OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
    };
  }

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      status: Order._statusFromString(json['status']),
      timestamp: DateTime.parse(json['timestamp']),
      note: json['note'],
    );
  }

  // Get display text for the status
  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return "Order Placed";
      case OrderStatus.confirmed:
        return "Order Confirmed";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }

  // Get description for the status
  String get description {
    switch (status) {
      case OrderStatus.pending:
        return "Your order has been placed and is awaiting confirmation";
      case OrderStatus.confirmed:
        return "Your order has been confirmed and is being processed";
      case OrderStatus.processing:
        return "Seller is preparing your order for shipment";
      case OrderStatus.shipped:
        return "Your order has been shipped and is on its way";
      case OrderStatus.delivered:
        return "Your order has been successfully delivered";
      case OrderStatus.cancelled:
        return "Your order has been cancelled";
    }
  }
}

class CartItem {
  final ProductModel product;
  final int quantity;
  final int? selectedColorIndex;
  final double totalPrice;

  CartItem({
    required this.product,
    required this.quantity,
    this.selectedColorIndex,
  }) : totalPrice = (double.tryParse(product.price.replaceAll('\$', '')) ?? 0) *
            quantity;

  CartItem copyWith({
    ProductModel? product,
    int? quantity,
    int? selectedColorIndex,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedColorIndex': selectedColorIndex,
      'totalPrice': totalPrice,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      selectedColorIndex: json['selectedColorIndex'],
    );
  }
}