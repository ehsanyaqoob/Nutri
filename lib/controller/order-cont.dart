import 'package:nutri/constants/export.dart';
import 'package:nutri/models/order-model.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderController extends GetxController {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  
  List<Order> get activeOrders {
    return _orders.where((order) => _isActiveOrder(order.status)).toList();
  }

  List<Order> get completedOrders {
    return _orders.where((order) => _isCompletedOrder(order.status)).toList();
  }

  bool _isActiveOrder(OrderStatus status) {
    return status != OrderStatus.delivered && 
           status != OrderStatus.cancelled;
  }

  bool _isCompletedOrder(OrderStatus status) {
    return status == OrderStatus.delivered || 
           status == OrderStatus.cancelled;
  }

  @override
  void onInit() {
    super.onInit();
    _simulateFetchOrders();
  }

  Future<void> _simulateFetchOrders() async {
    _isLoading = true;
    update();
    
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      _orders = await _getCachedOrders();
      
      // If no cached orders, create some sample data with status history
      if (_orders.isEmpty) {
        _orders = _createSampleOrders();
        await _cacheOrders();
      }
      
      print('✅ Loaded ${_orders.length} orders from cache');
    } catch (e) {
      print('❌ Error loading orders: $e');
      _orders = [];
    } finally {
      _isLoading = false;
      update();
    }
  }

  // Create sample orders with status history for testing
  List<Order> _createSampleOrders() {
    final now = DateTime.now();
    return [
      Order(
        orderNumber: 'ORD-001',
        orderDate: now.subtract(const Duration(days: 2)),
        items: [], // Add your sample items here
        totalAmount: 299.99,
        shippingAddress: '123 Main St, City, State',
        paymentMethod: 'Credit Card',
        status: OrderStatus.shipped,
        estimatedDelivery: now.add(const Duration(days: 3)),
        statusHistory: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: now.subtract(const Duration(days: 2, hours: 4)),
            note: 'Order placed successfully',
          ),
          OrderStatusUpdate(
            status: OrderStatus.confirmed,
            timestamp: now.subtract(const Duration(days: 2, hours: 3)),
            note: 'Payment confirmed',
          ),
          OrderStatusUpdate(
            status: OrderStatus.processing,
            timestamp: now.subtract(const Duration(days: 1)),
            note: 'Order is being processed',
          ),
          OrderStatusUpdate(
            status: OrderStatus.shipped,
            timestamp: now.subtract(const Duration(hours: 6)),
            note: 'Shipped via FedEx',
          ),
        ],
      ),
      Order(
        orderNumber: 'ORD-002',
        orderDate: now.subtract(const Duration(days: 5)),
        items: [], // Add your sample items here
        totalAmount: 159.99,
        shippingAddress: '456 Oak Ave, City, State',
        paymentMethod: 'PayPal',
        status: OrderStatus.delivered,
        estimatedDelivery: now.subtract(const Duration(days: 1)),
        statusHistory: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: now.subtract(const Duration(days: 5, hours: 2)),
          ),
          OrderStatusUpdate(
            status: OrderStatus.confirmed,
            timestamp: now.subtract(const Duration(days: 5, hours: 1)),
          ),
          OrderStatusUpdate(
            status: OrderStatus.processing,
            timestamp: now.subtract(const Duration(days: 4)),
          ),
          OrderStatusUpdate(
            status: OrderStatus.shipped,
            timestamp: now.subtract(const Duration(days: 3)),
          ),
          OrderStatusUpdate(
            status: OrderStatus.delivered,
            timestamp: now.subtract(const Duration(days: 1, hours: 5)),
            note: 'Delivered to front door',
          ),
        ],
      ),
    ];
  }

  void addNewOrder(Order order) {
    _orders.insert(0, order);
    _cacheOrders();
    update();
    print('✅ New order added: ${order.orderNumber}');
  }

  Future<void> _cacheOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = _orders.map((order) => order.toJson()).toList();
      await prefs.setString('cached_orders', json.encode(ordersJson));
      print('💾 Orders cached successfully: ${_orders.length} orders');
    } catch (e) {
      print('❌ Error caching orders: $e');
    }
  }

  Future<List<Order>> _getCachedOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString('cached_orders');
      
      if (ordersJson != null && ordersJson.isNotEmpty) {
        final List<dynamic> ordersList = json.decode(ordersJson);
        return ordersList.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        print('📝 No cached orders found, returning empty list');
        return [];
      }
    } catch (e) {
      print('❌ Error loading cached orders: $e');
      return [];
    }
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    update();
    
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      _orders = await _getCachedOrders();
      print('🔄 Refreshed orders: ${_orders.length} orders');
      AppToast.success("Orders updated!");
    } catch (e) {
      print('❌ Error refreshing orders: $e');
      AppToast.error("Failed to refresh orders");
    } finally {
      _isLoading = false;
      update();
    }
  }

  // Safe order retrieval
  Order? getOrderById(String orderNumber) {
    try {
      return _orders.firstWhere((order) => order.orderNumber == orderNumber);
    } catch (e) {
      return null;
    }
  }

  // Enhanced status update with history tracking
  void updateOrderStatus(String orderNumber, OrderStatus newStatus, {String? note}) {
    final orderIndex = _orders.indexWhere((order) => order.orderNumber == orderNumber);
    if (orderIndex != -1) {
      final oldOrder = _orders[orderIndex];
      final updatedOrder = oldOrder.addStatusUpdate(newStatus, note: note);
      
      _orders[orderIndex] = updatedOrder;
      _cacheOrders();
      update();
      print('✅ Order $orderNumber status updated to $newStatus');
    }
  }

  // Get status history for an order
  List<OrderStatusUpdate> getOrderStatusHistory(String orderNumber) {
    final order = getOrderById(orderNumber);
    return order?.statusHistory ?? [];
  }

  // Clear all orders (for testing)
  Future<void> clearAllOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_orders');
    _orders = [];
    update();
    print('🗑️ All orders cleared');
  }

  // Get orders by status
  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }
}