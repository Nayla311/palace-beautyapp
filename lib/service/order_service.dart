// lib/services/order_service.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/order.dart';
import '../utils/dummy_data.dart';

class OrderService extends ChangeNotifier {
  // Gunakan initialOrders sebagai data awal
  final List<Order> _orders = [];
  late Box<Order> _orderBox;
  final Completer<void> _initCompleter = Completer<void>();

  OrderService() {
    _initHive();
  }

  Future<void> _initHive() async {
    _orderBox = await Hive.openBox<Order>('orders');
    await _loadOrders();
    _initCompleter.complete();
  }

  Future<void> ensureInitialized() => _initCompleter.future;

  List<Order> get allOrders {
    // Urutkan berdasarkan tanggal dibuat terbaru (newest first)
    _orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(_orders);
  }

  // Digunakan oleh Admin untuk update status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await ensureInitialized();
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final oldOrder = _orders[index];
      // Pastikan status yang diberikan valid
      final validStatus =
          ['Confirmed', 'Completed', 'Cancelled'].contains(newStatus)
          ? newStatus
          : oldOrder.status;

      _orders[index] = oldOrder.copyWith(status: validStatus);
      await _saveOrders();
      notifyListeners(); // Beri tahu Consumer (UI) bahwa data telah berubah
    }
  }

  // Digunakan oleh User untuk menambahkan order baru
  Future<void> addOrder(Order order) async {
    await ensureInitialized();
    _orders.add(order);
    print('Order added: ${order.id} for customer: ${order.customerName}');
    await _saveOrders();
    notifyListeners();
  }

  // Digunakan oleh AdminDashboard untuk statistik
  Map<String, int> getOrderCounts() {
    int confirmed = 0;
    int completed = 0;
    int cancelled = 0;

    for (var order in _orders) {
      switch (order.status.toLowerCase()) {
        case 'confirmed':
          confirmed++;
          break;
        case 'completed':
          completed++;
          break;
        case 'cancelled':
          cancelled++;
          break;
      }
    }

    return {
      'All': _orders.length,
      'Confirmed': confirmed,
      'Completed': completed,
      'Cancelled': cancelled,
    };
  }

  // Load orders from Hive
  Future<void> _loadOrders() async {
    _orders.clear();
    _orders.addAll(_orderBox.values);
    notifyListeners();
  }

  // Save orders to Hive
  Future<void> _saveOrders() async {
    await _orderBox.clear();
    await _orderBox.addAll(_orders);
  }
}
