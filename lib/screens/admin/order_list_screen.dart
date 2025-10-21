// lib/screens/admin/order_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/order_service.dart';
import '../../widgets/order_card.dart';
import 'order_detail_screen.dart';

class AdminOrderListScreen extends StatefulWidget {
  const AdminOrderListScreen({super.key});

  @override
  State<AdminOrderListScreen> createState() => _AdminOrderListScreenState();
}

class _AdminOrderListScreenState extends State<AdminOrderListScreen> {
  String _selectedFilter = 'All';

  List<String> get _statusFilters => [
    'All',
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  List<OrderCard> _getFilteredOrders(OrderService orderService) {
    final allOrders = orderService.allOrders;
    final filteredOrders = allOrders.where((order) {
      if (_selectedFilter == 'All') return true;
      return order.status.toLowerCase() == _selectedFilter.toLowerCase();
    }).toList();

    if (filteredOrders.isEmpty) {
      return [
        OrderCard(
          order: allOrders.first.copyWith(
            serviceName: 'No ${_selectedFilter} Orders Found',
            serviceCategory: 'System',
            price: '',
            duration: '',
            status: 'Pending',
            customerName: '',
            customerPhone: '',
            notes: 'Try selecting a different filter.',
          ),
          onTap: () {},
        ),
      ];
    }

    return filteredOrders.map((order) {
      return OrderCard(
        order: order,
        onTap: () {
          // Navigasi ke Detail Admin
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminOrderDetailScreen(order: order),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer untuk mendapatkan data pesanan dan counts
    return Consumer<OrderService>(
      builder: (context, orderService, child) {
        final filteredCards = _getFilteredOrders(orderService);
        final counts = orderService.getOrderCounts();

        return Scaffold(
          backgroundColor: const Color(0xFFFDF3F4),
          appBar: AppBar(
            backgroundColor: Colors.pink,
            elevation: 0,
            title: const Text(
              'Manage Orders',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              // Filter Tabs
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _statusFilters.map((label) {
                      final count = counts[label] ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildFilterChip(label, count),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Orders List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: filteredCards,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, int count) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
      selectedColor: Colors.pink.shade100,
      checkmarkColor: Colors.pink.shade600,
      labelStyle: TextStyle(
        color: isSelected ? Colors.pink.shade600 : Colors.grey.shade600,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? Colors.pink.shade300 : Colors.grey.shade300,
      ),
    );
  }
}
