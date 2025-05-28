import 'package:Invome/core/configs/assets/app_images.dart';
import 'package:Invome/core/configs/theme/app_colors.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import '../create_invoice/select_template.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  bool firstSwitchValue = false;
  List<String> options = ['All', 'Open', 'Paid', 'Draft'];
  String selectedOption = 'All';

  Widget _buildToggleSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: AnimatedToggleSwitch<String>.size(
        current: selectedOption,
        values: options,
        iconOpacity: 0.7,
        customSeparatorBuilder: (context, local, global) {
          return VerticalDivider(
            indent: 10.0,
            endIndent: 10.0,
            color: Colors.black26,
          );
        },
        height: 43,
        spacing: 6,
        padding: EdgeInsets.all(2.5),
        indicatorSize: const Size.fromWidth(88),
        customIconBuilder: (context, local, global) {
          return Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              local.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.lerp(
                  Colors.black,
                  Colors.white,
                  local.animationValue,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        iconAnimationType: AnimationType.onHover,
        borderWidth: 0.7,
        style: ToggleStyle(
          indicatorColor: AppColors.primary,
          backgroundColor: Colors.transparent,
          borderColor: Colors.black26,
          borderRadius: BorderRadius.circular(18),
        ),
        selectedIconScale: 1.0,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
        },
      ),
    );
  }

  Widget _invoiceCard({
    required String invoiceIcon,
    required String invoiceName,
    required String invoiceNumber,
    required String invoiceDueDate,
    required String invoiceAmount,
    required String invoiceStatus,
  }) {
    return Container(
      width: double.infinity,
      height: 74,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color(0xfff6f5f5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 7,
              children: [
                Image.asset(invoiceIcon, width: 54, height: 54),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoiceName,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Invoice #$invoiceNumber • Due $invoiceDueDate',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  invoiceAmount,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  invoiceStatus,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
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
        return SelectTemplate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoices',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),

                  CircleAvatar(
                    radius: 21,
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      color: AppColors.surface,
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add, size: 27, color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),
              _buildToggleSwitch(),
              SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      'TODAY',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _invoiceCard(
                    invoiceIcon: AppImages.invoice,
                    invoiceName: 'LendFlow',
                    invoiceNumber: '6',
                    invoiceDueDate: 'Jan 14',
                    invoiceAmount: '\$500.00',
                    invoiceStatus: 'Open',
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      'THIS MONTH',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _invoiceCard(
                    invoiceIcon: AppImages.invoicePaid,
                    invoiceName: 'Nike',
                    invoiceNumber: '9',
                    invoiceDueDate: 'Sept 10',
                    invoiceAmount: '\$1,359.00',
                    invoiceStatus: 'Paid',
                  ),
                  _invoiceCard(
                    invoiceIcon: AppImages.invoicePaid,
                    invoiceName: 'Tesla ltd.',
                    invoiceNumber: '12',
                    invoiceDueDate: 'Sept 11',
                    invoiceAmount: '\$6,100.00',
                    invoiceStatus: 'Paid',
                  ),
                  _invoiceCard(
                    invoiceIcon: AppImages.invoice,
                    invoiceName: 'Canon',
                    invoiceNumber: '13',
                    invoiceDueDate: 'Jan 28',
                    invoiceAmount: '\$120.00',
                    invoiceStatus: 'Open',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
