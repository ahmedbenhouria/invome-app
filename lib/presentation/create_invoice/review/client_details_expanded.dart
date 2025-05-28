import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/invoice.dart';

class ClientDetailsExpanded extends StatefulWidget {
  final Invoice invoice;

  const ClientDetailsExpanded({super.key, required this.invoice});

  @override
  State<ClientDetailsExpanded> createState() => _ClientDetailsExpandedState();
}

class _ClientDetailsExpandedState extends State<ClientDetailsExpanded>
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
                          'CLIENT DETAILS',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailColumn('TITLE', invoice.info.description),
                        _buildDetailColumn(
                          'NUMBER',
                          invoice.info.number,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailColumn(
                          'INVOICE DATE',
                          invoice.info.date.toLocal().toString().split(' ')[0],
                        ),
                        _buildDetailColumn(
                          'DUE IN',
                          '30 Days',
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        _buildDetailColumn(
                          'DUE DATE',
                          invoice.info.dueDate.toLocal().toString().split(
                            ' ',
                          )[0],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),

                    Divider(color: Colors.grey.shade200, thickness: 1),

                    _buildDetailRow('CLIENT NAME', invoice.customer.name),
                    _buildDetailRow('EMAIL', invoice.customer.email),
                    _buildDetailRow('MOBILE NUMBER', invoice.customer.phone),

                    Divider(color: Colors.grey.shade200, thickness: 1),

                    _buildDetailColumn('BILLED TO', invoice.customer.address),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(
    String label,
    String value, {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

Widget _buildDetailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    ],
  );
}
