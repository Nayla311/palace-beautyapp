// lib/screens/admin/order_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:palace_beautyapp/service/order_service.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../service/order_service.dart';

class AdminOrderDetailScreen extends StatelessWidget {
  final Order order;

  const AdminOrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3F4),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: const Text(
          'Order Details (Admin)',
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
            _buildHeaderCard(),
            const SizedBox(height: 16),
            _buildInfoCard('Booking Info', [
              _infoRow(Icons.calendar_today, 'Date', order.getFormattedDate()),
              _infoRow(Icons.access_time, 'Time', order.bookingTime),
              _infoRow(Icons.timer, 'Duration', order.duration),
              _infoRow(Icons.attach_money, 'Price', order.price),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Customer Info', [
              _infoRow(Icons.person, 'Name', order.customerName),
              _infoRow(Icons.phone, 'Phone', order.customerPhone),
            ]),
            const SizedBox(height: 16),

            // Notes
            if (order.notes != null && order.notes!.isNotEmpty)
              _buildInfoCard('Notes', [Text(order.notes!)]),

            const SizedBox(height: 24),

            // --- Admin Actions ---
            _buildAdminActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID: ${order.id}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
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
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            order.serviceName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            order.serviceCategory,
            style: TextStyle(
              fontSize: 14,
              color: Colors.pink.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
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
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ...children
              .map(
                (child) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: child,
                ),
              )
              .toList(),
        ],
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

  Widget _buildAdminActions(BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: false);
    final currentStatus = order.status.toLowerCase();

    // Tombol untuk order yang sudah Dikonfirmasi/Confirmed (bisa diubah menjadi Completed/Cancelled)
    if (currentStatus == 'confirmed') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () =>
                  _updateStatus(context, orderService, 'Completed'),
              icon: const Icon(Icons.done_all),
              label: const Text('Mark as Completed'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () =>
                  _updateStatus(context, orderService, 'Cancelled'),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancel Order'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Status: ${order.status}',
          style: TextStyle(
            color: order.getStatusColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _updateStatus(
    BuildContext context,
    OrderService service,
    String newStatus,
  ) {
    service.updateOrderStatus(order.id, newStatus).then((_) {
      // Handle success if needed
    }).catchError((error) {
      // Handle error if needed
      print('Error updating order status: $error');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order.id} status updated to $newStatus!'),
        backgroundColor: newStatus == 'Confirmed' ? Colors.green : Colors.red,
      ),
    );
    Navigator.pop(context); // Kembali ke daftar setelah update
  }
}
