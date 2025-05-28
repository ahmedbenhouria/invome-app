import 'package:Invome/core/configs/utils/client_details_validator.dart';
import 'package:Invome/presentation/create_invoice/widgets/text_field_widget.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_date_picker.dart';

class ClientDetails extends StatelessWidget {
  final GlobalKey formKey;

  const ClientDetails({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController subjectController = TextEditingController();
    TextEditingController clientNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController clientAddressController = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Client Details',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Fields marked with * are required.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Invoice Title',
                  hintText: 'Example: Tax Invoice',
                  controller: titleController,
                  validator:
                      (value) => ClientDetailsFormValidator.requiredField(
                        value,
                        fieldName: 'Invoice title',
                      ),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Invoice Number',
                  hintText: '#',
                  controller: numberController,
                  validator:
                      (value) => ClientDetailsFormValidator.requiredField(
                        value,
                        fieldName: 'Invoice number',
                      ),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Invoice Subject',
                  hintText: 'Example: Web Template Design',
                  controller: subjectController,
                  isRequired: false,
                ),
                SizedBox(height: 15),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Invoice Date',
                        firstDate: DateTime.now().add(const Duration(days: 10)),
                        lastDate: DateTime.now().add(const Duration(days: 40)),
                        initialDate: DateTime.now().add(
                          const Duration(days: 20),
                        ),
                        onChanged: (val) => print(val),
                        validator:
                            (value) =>
                                value == null
                                    ? 'Invoice date is required'
                                    : null,
                      ),
                    ),
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Due Date',
                        firstDate: DateTime.now().add(const Duration(days: 10)),
                        lastDate: DateTime.now().add(const Duration(days: 40)),
                        initialDate: DateTime.now().add(
                          const Duration(days: 20),
                        ),
                        onChanged: (val) => print(val),
                        validator:
                            (value) =>
                                value == null ? 'Due date is required' : null,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(color: Colors.grey.shade200, thickness: 1),
                ),
                TextFieldWidget(
                  label: 'Client Name',
                  hintText: 'Suggestion will appear as you type...',
                  controller: clientNameController,
                  validator:
                      (value) => ClientDetailsFormValidator.requiredField(
                        value,
                        fieldName: 'Client name',
                      ),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Email Address',
                  hintText: 'Enter email',
                  controller: emailController,
                  isRequired: false,
                  validator:
                      (value) =>
                          ClientDetailsFormValidator.validateEmail(value),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Phone Number',
                  hintText: '',
                  controller: phoneNumberController,
                  isRequired: false,
                  validator:
                      (value) =>
                          ClientDetailsFormValidator.validatePhone(value),
                ),
                SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Bill To',
                  hintText: 'Enter Client Address',
                  controller: clientAddressController,
                  validator:
                      (value) => ClientDetailsFormValidator.requiredField(
                        value,
                        fieldName: 'Client address',
                      ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
