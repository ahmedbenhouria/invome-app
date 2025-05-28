import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime?) onChanged;
  final String? Function(DateTime?)? validator;
  final bool isRequired;

  const CustomDatePicker({
    super.key,
    required this.label,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    this.validator,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        FormField<DateTime>(
          validator: validator,
          builder: (FormFieldState<DateTime> state) {
            final hasError = state.hasError;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 44,
                  child: DateTimeFormField(
                    mode: DateTimeFieldPickerMode.date,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                          size: 19,
                        ),
                      ),
                      hintText: 'Enter Date',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      border: _inputBorder(hasError, errorColor),
                      enabledBorder: _inputBorder(hasError, errorColor),
                      focusedBorder: _inputBorder(
                        hasError,
                        errorColor,
                        isFocused: true,
                      ),
                    ),
                    firstDate: firstDate,
                    lastDate: lastDate,
                    initialPickerDateTime: initialDate,
                    onChanged: (val) {
                      state.didChange(val);
                      onChanged(val);
                    },
                  ),
                ),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(color: errorColor, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildLabel() {
    return Text.rich(
      TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
        children: [
          if (isRequired)
            const TextSpan(text: '*', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  InputBorder _inputBorder(
    bool hasError,
    Color errorColor, {
    bool isFocused = false,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color:
            hasError
                ? errorColor
                : isFocused
                ? Colors.grey.shade300
                : Colors.grey.shade200,
        width: 1.0,
      ),
    );
  }
}
