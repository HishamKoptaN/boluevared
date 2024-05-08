import 'customer.dart';
import 'supplier.dart';

class Order {
  final OrderInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<OrderItem> items;

  const Order.order({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class OrderInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const OrderInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class OrderItem {
  final String shopNumber;
  final int rentValue;
  final bool? isBooked;
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;
  final double width;
  final double height;
  final double totalShopArea;

  OrderItem({
    required this.shopNumber,
    required this.rentValue,
    this.isBooked,
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
    required this.width,
    required this.height,
    required this.totalShopArea,
  });
}
