import 'package:Invome/domain/entities/supplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String name; // e.g. "Item Name"
  final String description; // e.g. "Item description"
  final int quantity; // e.g. 1
  final double unitPrice; // e.g. 3000.0
  final double discount;
  final double vat; // e.g. 10.0 (percent)

  const InvoiceItem({
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.vat,
  });

  double get total {
    final discounted = unitPrice * (1 - discount / 100);
    return discounted * quantity;
  }

  double get totalWithVat => total + (total * vat / 100);
}

double getInvoiceSubtotal(Invoice invoice) {
  return invoice.items.fold(0, (sum, item) => sum + item.total);
}

double getInvoiceTotalVat(Invoice invoice) {
  return invoice.items.fold(
    0,
    (sum, item) => sum + (item.total * item.vat / 100),
  );
}

double getGrandTotal(Invoice invoice) {
  return getInvoiceSubtotal(invoice) + getInvoiceTotalVat(invoice);
}
