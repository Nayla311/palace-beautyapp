import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 0)
class Order {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String serviceName;
  @HiveField(2)
  final String serviceCategory;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String duration;
  @HiveField(5)
  final DateTime bookingDate;
  @HiveField(6)
  final String bookingTime;
  @HiveField(7)
  final String customerName;
  @HiveField(8)
  final String customerPhone;
  @HiveField(9)
  final String status; // confirmed, completed, cancelled
  @HiveField(10)
  final String paymentMethod; // bank transfer, dana, ovo, gopay, cash
  @HiveField(11)
  final DateTime createdAt;
  @HiveField(12)
  final String? notes;

  Order({
    required this.id,
    required this.serviceName,
    required this.serviceCategory,
    required this.price,
    required this.duration,
    required this.bookingDate,
    required this.bookingTime,
    required this.customerName,
    required this.customerPhone,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    this.notes,
  });

  // Generate order ID
  static String generateOrderId() {
    final now = DateTime.now();
    return 'BP${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.millisecondsSinceEpoch.toString().substring(8)}';
  }

  // Get status color
  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get status icon
  IconData getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'completed':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  // Format date
  String getFormattedDate() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${bookingDate.day} ${months[bookingDate.month - 1]} ${bookingDate.year}';
  }

  // Copy with method for updating order
  Order copyWith({
    String? id,
    String? serviceName,
    String? serviceCategory,
    String? price,
    String? duration,
    DateTime? bookingDate,
    String? bookingTime,
    String? customerName,
    String? customerPhone,
    String? status,
    String? paymentMethod,
    DateTime? createdAt,
    String? notes,
  }) {
    return Order(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'serviceCategory': serviceCategory,
      'price': price,
      'duration': duration,
      'bookingDate': bookingDate.toIso8601String(),
      'bookingTime': bookingTime,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'status': status,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'notes': notes,
    };
  }

  // Create from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      serviceName: json['serviceName'],
      serviceCategory: json['serviceCategory'],
      price: json['price'],
      duration: json['duration'],
      bookingDate: DateTime.parse(json['bookingDate']),
      bookingTime: json['bookingTime'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      notes: json['notes'],
    );
  }
}
