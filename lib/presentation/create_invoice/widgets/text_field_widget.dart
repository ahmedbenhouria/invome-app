import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool? obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isRequired;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.isRequired = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        _buildLabel(),

        FormField<String>(
          validator: (value) {
            if (validator != null) return validator!(value);
            return null;
          },
          builder: (FormFieldState<String> state) {
            final hasError = state.hasError;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: TextFormField(
                          controller: controller,
                          obscureText: obscureText ?? false,
                          keyboardType: keyboardType,
                          inputFormatters:
                              keyboardType == TextInputType.number
                                  ? [FilteringTextInputFormatter.digitsOnly]
                                  : null,
                          readOnly: prefixIcon != null,
                          textAlign:
                              prefixIcon != null
                                  ? TextAlign.center
                                  : TextAlign.start,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          onChanged: (value) => state.didChange(value),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17,
                            ),
                            hintText: hintText,
                            suffixIcon: suffixIcon,
                            prefixIcon: prefixIcon,
                            border: _inputBorder(hasError, errorColor),
                            enabledBorder: _inputBorder(hasError, errorColor),
                            focusedBorder: _inputBorder(
                              hasError,
                              errorColor,
                              isFocused: true,
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (label == 'Client Name') ...[
                      const SizedBox(width: 13),
                      _buildAddButton(),
                    ],
                  ],
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
            TextSpan(text: '*', style: TextStyle(color: Colors.red)),
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

  Widget _buildAddButton() {
    return Container(
      width: 41,
      height: 42.5,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          AppVectors.plus,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
