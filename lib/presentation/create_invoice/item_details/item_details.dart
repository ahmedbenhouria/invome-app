import 'package:Invome/presentation/create_invoice/item_details/invoice_expanded_item.dart';
import 'package:Invome/presentation/create_invoice/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/invoice.dart';
import '../../../domain/entities/supplier.dart';
import 'add_additional_charges.dart';
import 'add_item.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  TextEditingController notesController = TextEditingController();

  void _showAddItemBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black87.withOpacity(0.5),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return AddItem();
      },
    );
  }

  void _showAdditionalChargesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black87.withOpacity(0.5),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return AddAdditionalCharges();
      },
    );
  }

  final invoice = Invoice(
    info: InvoiceInfo(
      description: 'Website development and SEO optimization services',
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
    items: [],
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable item section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (invoice.items.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ITEMS',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Delete All',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Render invoice item list
                      ListView.separated(
                        itemCount: invoice.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder:
                            (context, index) =>
                                InvoiceExpandedItem(item: invoice.items[index]),
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 5),
                      ),

                      const SizedBox(height: 15),
                    ],
                    // Add Item Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showAddItemBottomSheet(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_rounded,
                              size: 24,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Add Item',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 11),
                    Divider(color: Colors.grey.shade200, thickness: 1),
                    const SizedBox(height: 11),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _showAdditionalChargesBottomSheet(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 7,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  size: 19,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                'Additional Charges',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 11),
                        Divider(color: Colors.grey.shade200, thickness: 1),
                        const SizedBox(height: 11),

                        TextFieldWidget(
                          label: 'Notes',
                          hintText: 'Add additional information if required',
                          controller: notesController,
                          isRequired: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom summary
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          getGrandTotal(invoice).toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            height: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Price Breakdown',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
