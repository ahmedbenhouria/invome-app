import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/invoice.dart';

class ItemDetailsExpanded extends StatefulWidget {
  final Invoice invoice;

  const ItemDetailsExpanded({super.key, required this.invoice});

  @override
  State<ItemDetailsExpanded> createState() => _ItemDetailsExpandedState();
}

class _ItemDetailsExpandedState extends State<ItemDetailsExpanded>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.grey.shade50,
              highlightColor: Colors.grey.shade100,
              onTap: () => setState(() => _expanded = !_expanded),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
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
                          'ITEM DETAILS',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        'Edit',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
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
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 10,
                ),
                child: // Render invoice item list
                    ListView.separated(
                  itemCount: invoice.items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = invoice.items[index];
                    final String itemName = item.name;
                    final double rate = item.unitPrice;
                    final int qty = item.quantity;
                    final double itemTotal = item.totalWithVat;
                    return _buildItemRow(
                      itemName,
                      rate.toStringAsFixed(2),
                      qty.toString(),
                      itemTotal.toStringAsFixed(2),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey.shade200, thickness: 1);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(
    String itemName,
    String rate,
    String qty,
    String itemTotal,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  'RATE: $rate',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  ' | QTY: $qty',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          itemTotal,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
