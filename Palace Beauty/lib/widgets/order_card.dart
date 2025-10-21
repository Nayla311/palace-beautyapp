// lib/widgets/order_card.dart
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Order ID & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        order.id,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: order.getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: order.getStatusColor().withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          order.getStatusIcon(),
                          size: 14,
                          color: order.getStatusColor(),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: order.getStatusColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Service Name
              Text(
                order.serviceName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),

              // Booking Details
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${order.getFormattedDate()}, ${order.bookingTime}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // Price
                  Text(
                    order.price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Category Badge (bottom)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.serviceCategory,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
