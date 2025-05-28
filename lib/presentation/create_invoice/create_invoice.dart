import 'dart:io';

import 'package:Invome/presentation/create_invoice/client_details/client_details.dart';
import 'package:Invome/presentation/create_invoice/item_details/item_details.dart';
import 'package:Invome/presentation/create_invoice/pdf/pdf_file_manager.dart';
import 'package:Invome/presentation/create_invoice/pdf/invoice_templates/invoice_template1.dart';
import 'package:Invome/presentation/create_invoice/review/review.dart';
import 'package:Invome/presentation/create_invoice/widgets/action_button_widget.dart';
import 'package:Invome/presentation/create_invoice/widgets/dashed_line_painter.dart';
import 'package:Invome/presentation/create_invoice/widgets/step_circle.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/supplier.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  int _currentStep = 0;
  int _previousStep = 0;

  final List<String> _stepLabels = ['Client Details', 'Item Details', 'Review'];
  final double _circleSize = 21;

  void _nextStep() {
    setState(() {
      _previousStep = _currentStep;
      _currentStep++;
    });
  }

  void _prevStep() {
    setState(() {
      _previousStep = _currentStep;
      _currentStep--;
    });
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

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    } else {
      await Permission.storage.request();
    }
  }

  Future<bool> checkPermissions(BuildContext context) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.manageExternalStorage.status;
    } else {
      status = await Permission.storage.status;
    }

    if (status.isGranted) {
      return true;
    } else {
      await requestPermission();

      // Recheck after requesting
      final newStatus =
          Platform.isAndroid
              ? await Permission.manageExternalStorage.status
              : await Permission.storage.status;

      if (!newStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage permission is required to save PDF.'),
          ),
        );
        return false;
      }

      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        leading: const BackButton(),
        title: const Text(
          'Create New Invoice',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepper(),

            Expanded(
              child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 400),
                reverse: _currentStep < _previousStep,
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
                child: _buildStepContent(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStepper() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 38,
            right: 38,
            top: 10,
            child: Row(
              children: List.generate(_stepLabels.length - 1, (index) {
                return const Expanded(
                  child: CustomPaint(
                    painter: DashedLinePainter(color: Colors.black26),
                    child: SizedBox(height: 1),
                  ),
                );
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_stepLabels.length, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StepCircle(
                    isCompleted: index < _currentStep,
                    isCurrent: index == _currentStep,
                    size: _circleSize,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 90,
                    child: Text(
                      _stepLabels[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return ClientDetails(formKey: _formKey);
      case 1:
        return ItemDetails();
      case 2:
        return Review();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomBar() {
    final isLastStep = _currentStep == _stepLabels.length - 1;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Row(
          mainAxisAlignment:
              _currentStep == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
          children: [
            if (!isLastStep) ...[
              if (_currentStep > 0)
                ActionButtonWidget(
                  text: 'Back',
                  color: AppColors.surface,
                  textColor: AppColors.primary,
                  onPressed: _prevStep,
                  width: 150,
                ),
              ActionButtonWidget(
                text: 'Next',
                color: AppColors.primary,
                textColor: Colors.white,
                width: _currentStep == 0 ? 260 : 150,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _nextStep();
                  }
                },
              ),
            ] else ...[
              ActionButtonWidget(
                text: 'Back',
                color: AppColors.surface,
                textColor: AppColors.primary,
                onPressed: _prevStep,
                width: 150,
              ),
              ActionButtonWidget(
                text: 'Generate',
                color: AppColors.primary,
                textColor: Colors.white,
                width: 150,
                onPressed: () async {
                  final hasPermission = await checkPermissions(context);
                  if (!hasPermission) return;

                  final pdfFile = await InvoiceTemplate1.generate(
                    invoice,
                    '${invoice.info.number}.pdf',
                  );

                  PdfFileManager.openFile(pdfFile);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
