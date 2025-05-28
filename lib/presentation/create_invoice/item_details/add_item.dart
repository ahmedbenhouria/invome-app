import 'package:Invome/presentation/create_invoice/widgets/action_button_widget.dart';
import 'package:Invome/presentation/create_invoice/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(text: quantity.toString());
  }

  void _increment() {
    setState(() {
      quantity++;
      quantityController.text = quantity.toString();
    });
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        quantityController.text = quantity.toString();
      });
    }
  }

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
                    'Item Details',
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
                    label: 'Item Name',
                    hintText: 'Enter Item Name',
                    controller: itemNameController,
                  ),
                  TextFieldWidget(
                    label: 'Item Description',
                    hintText: 'Enter Item Description',
                    controller: itemNameController,
                    isRequired: false,
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Rate',
                          hintText: '',
                          controller: rateController,
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 13, right: 18),
                            child: Text(
                              'USD',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Quantity',
                          hintText: '',
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(6.7),
                            child: Container(
                              width: 15,
                              height: 15,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: Colors.black,
                                ),
                                onPressed: _decrement,
                              ),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6.7),
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.black,
                                ),
                                onPressed: _increment,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Item Discount',
                          hintText: '',
                          controller: rateController,
                          keyboardType: TextInputType.number,
                          isRequired: false,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 15),
                            child: Text(
                              '%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Tax',
                          hintText: '',
                          controller: rateController,
                          keyboardType: TextInputType.number,
                          isRequired: false,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 15),
                            child: Text(
                              '%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Divider(color: Colors.grey.shade200, thickness: 1),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      spacing: 7,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '600.00',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '- 90.00',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '+ 108.00',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '618.00',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 2),
                        SizedBox(
                          width: 260,
                          child: ActionButtonWidget(
                            text: 'Done',
                            color: AppColors.primary,
                            textColor: Colors.white,
                            onPressed: () {},
                            width: 260,
                          ),
                        ),
                      ],
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
