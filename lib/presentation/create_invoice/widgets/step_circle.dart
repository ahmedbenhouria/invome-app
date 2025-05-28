import 'package:Invome/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/theme/app_colors.dart';

class StepCircle extends StatelessWidget {
  final bool isCompleted;
  final bool isCurrent;
  final double size;

  const StepCircle({
    super.key,
    required this.isCompleted,
    required this.isCurrent,
    required this.size,
  });

  static const Color _activeColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isCompleted ? _activeColor : Colors.white,
        shape: BoxShape.circle,
        border:
            isCompleted
                ? null
                : Border.all(
                  color: isCurrent ? _activeColor : Colors.grey.shade400,
                  width: 1.0,
                ),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              isCompleted
                  ? SvgPicture.asset(
                    AppVectors.check,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  )
                  : isCurrent
                  ? Container(
                    key: const ValueKey('dot'),
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: _activeColor,
                      shape: BoxShape.circle,
                    ),
                  )
                  : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ),
    );
  }
}
