// lib/screens/order_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3F4),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header / status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.serviceName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          order.serviceCategory,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.pink.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.id,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: order.getStatusColor().withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              order.getStatusIcon(),
                              size: 14,
                              color: order.getStatusColor(),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              order.status,
                              style: TextStyle(
                                color: order.getStatusColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Booking info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(
                    Icons.calendar_today,
                    'Date',
                    order.getFormattedDate(),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.access_time, 'Time', order.bookingTime),
                  const SizedBox(height: 8),
                  _infoRow(Icons.timer, 'Duration', order.duration),
                  const SizedBox(height: 8),
                  _infoRow(Icons.attach_money, 'Price', order.price),
                  const SizedBox(height: 8),
                  _infoRow(Icons.payment, 'Payment Method', order.paymentMethod),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Customer info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.person, 'Name', order.customerName),
                  const SizedBox(height: 8),
                  _infoRow(Icons.phone, 'Phone', order.customerPhone),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Notes
            if (order.notes != null && order.notes!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(order.notes!),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Actions (example: cancel or mark complete) - optional
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Placeholder action: bisa ganti status atau panggil API
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Action clicked (implement as needed)'),
                        ),
                      );
                    },
                    child: const Text('Take Action'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        Expanded(child: Text(value)),
      ],
    );
  }
}
