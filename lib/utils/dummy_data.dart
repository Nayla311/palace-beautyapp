// lib/utils/dummy_data.dart
import '../models/order.dart';
import '../models/user.dart';

// ADMIN USER CREDENTIALS
// Digunakan untuk simulasi login admin.
final User dummyAdminUser = User(
  'admin@gmail.com',
  'admin123', // Password Admin
  'Admin Palace',
  DateTime.now(),
  role: 'admin',
);

// INITIAL ORDERS (Data Dummy)
final List<Order> initialOrders = [];
