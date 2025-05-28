import 'package:Invome/presentation/create_invoice/widgets/action_button_widget.dart';
import 'package:Invome/presentation/create_invoice/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

class AddAdditionalCharges extends StatefulWidget {
  const AddAdditionalCharges({super.key});

  @override
  State<AddAdditionalCharges> createState() => _AddAdditionalChargesState();
}

class _AddAdditionalChargesState extends State<AddAdditionalCharges> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom - 180,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Additional Charges',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, size: 19),
                  ),
                ],
              ),
              SizedBox(height: 17),
              Column(
                spacing: 15,
                children: [
                  TextFieldWidget(
                    label: 'Type of Charge',
                    hintText: 'Example: Shipping',
                    controller: itemNameController,
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Value',
                          hintText: '',
                          controller: rateController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Unit',
                          hintText: '',
                          controller: rateController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: SizedBox(
                      width: 260,
                      child: ActionButtonWidget(
                        text: 'Done',
                        color: AppColors.primary,
                        textColor: Colors.white,
                        onPressed: () {},
                        width: 260,
                      ),
                    ),
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
