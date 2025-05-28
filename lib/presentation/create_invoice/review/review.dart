import 'package:Invome/presentation/create_invoice/review/client_details_expanded.dart';
import 'package:Invome/presentation/create_invoice/review/item_details_expanded.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/customer.dart';
import '../../../domain/entities/invoice.dart';
import '../../../domain/entities/supplier.dart';

class Review extends StatelessWidget {
  Review({super.key});

  final invoice = Invoice(
    info: InvoiceInfo(
      description: 'Tax Invoice',
      number: 'INV-2025-001',
      date: DateTime(2025, 5, 15),
      dueDate: DateTime(2025, 6, 15),
    ),
    supplier: Supplier(
      name: 'TechNova Solutions LLC',
      address: '123 Silicon Street, TX 75001',
      email: 'contact@technova.com',
      phone: '+1 (555) 123-4567',
      website: 'www.technova.com',
      taxId: 'TXN-4528-9987',
    ),
    customer: Customer(
      name: 'Acme Corporation',
      address: '987 Industrial Ave, Business Town',
      email: 'contact@technova.com',
      phone: '+1 (555) 987-6543',
    ),
    items: [
      InvoiceItem(
        name: 'Website Design',
        description: 'Custom responsive website design',
        quantity: 1,
        unitPrice: 2500.0,
        discount: 0,
        vat: 10.0,
      ),
      InvoiceItem(
        name: 'SEO Optimization',
        description: 'Search engine optimization for 6 pages',
        quantity: 1,
        unitPrice: 1200.0,
        discount: 0,
        vat: 10.0,
      ),
      InvoiceItem(
        name: 'Maintenance Plan',
        description: 'Monthly site maintenance for 3 months',
        quantity: 3,
        unitPrice: 200.0,
        discount: 0,
        vat: 10.0,
      ),
      InvoiceItem(
        name: 'Maintenance Plan',
        description: 'Monthly site maintenance for 8 months',
        quantity: 8,
        unitPrice: 100.0,
        discount: 0,
        vat: 10.0,
      ),
      InvoiceItem(
        name: 'Maintenance Plan',
        description: 'Monthly site maintenance for 1 months',
        quantity: 2,
        unitPrice: 500.0,
        discount: 0,
        vat: 10.0,
      ),
      InvoiceItem(
        name: 'Maintenance Plan',
        description: 'Monthly site maintenance for 1 months',
        quantity: 2,
        unitPrice: 500.0,
        discount: 0,
        vat: 10.0,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClientDetailsExpanded(invoice: invoice),
                  ItemDetailsExpanded(invoice: invoice),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
