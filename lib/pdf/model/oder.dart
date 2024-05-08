import 'customer.dart';
import 'supplier.dart';

class Order {
  // final OrderInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<OrderItem> items;
  const Order.order({
    // required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class OrderInfo {
  // final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  const OrderInfo({
    // required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class OrderItem {
  final int shopNumber;
  final int rentValue;
  final bool? isBooked;
  final int width;
  final int height;
  final int totalShopArea;

  OrderItem({
    required this.shopNumber,
    required this.rentValue,
    this.isBooked,
    required this.width,
    required this.height,
    required this.totalShopArea,
  });
}
