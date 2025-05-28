import 'package:flutter/material.dart';

import '../../../domain/entities/invoice.dart';

class InvoiceExpandedItem extends StatefulWidget {
  final InvoiceItem item;

  const InvoiceExpandedItem({super.key, required this.item});

  @override
  State<InvoiceExpandedItem> createState() => _InvoiceExpandedItemState();
}

class _InvoiceExpandedItemState extends State<InvoiceExpandedItem>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.grey.shade50,
              highlightColor: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(_expanded ? 0 : 8),
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.5),
                      child: Icon(
                        _expanded
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_right_rounded,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      item.totalWithVat.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.5),
                      child: Icon(
                        Icons.more_vert,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded content
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints:
                  _expanded
                      ? const BoxConstraints()
                      : const BoxConstraints(maxHeight: 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailColumn(
                      'RATE',
                      item.unitPrice.toStringAsFixed(2),
                    ),
                    _buildDetailColumn('QTY', item.quantity.toString()),
                    _buildDetailColumn(
                      'DISCOUNT',
                      item.discount.toStringAsFixed(2) ?? '0.00',
                    ),
                    _buildDetailColumn(
                      'VAT',
                      '${item.vat.toStringAsFixed(0)}%',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
