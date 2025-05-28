import 'package:flutter/material.dart';

class QuantityTextFieldWidget extends StatefulWidget {
  final int initialValue;
  final void Function(int)? onChanged;

  const QuantityTextFieldWidget({
    super.key,
    this.initialValue = 0,
    this.onChanged,
  });

  @override
  State<QuantityTextFieldWidget> createState() =>
      _QuantityTextFieldWidgetState();
}

class _QuantityTextFieldWidgetState extends State<QuantityTextFieldWidget> {
  late TextEditingController _controller;
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
    _controller = TextEditingController(text: quantity.toString());
  }

  void _increment() {
    setState(() {
      quantity++;
      _controller.text = quantity.toString();
      widget.onChanged?.call(quantity);
    });
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        _controller.text = quantity.toString();
        widget.onChanged?.call(quantity);
      });
    }
  }

  void _onTextChanged(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 0) {
      quantity = parsed;
      widget.onChanged?.call(quantity);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            text: 'Quantity ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            children: [
              TextSpan(text: '*', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: _onTextChanged,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrement,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _increment,
            ),
          ),
        ),
      ],
    );
  }
}
