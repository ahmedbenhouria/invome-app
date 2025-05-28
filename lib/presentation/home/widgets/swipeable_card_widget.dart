import 'package:flutter/material.dart';

// Swipeable card for invoices
class SwipeableCardWidget extends StatefulWidget {
  final double height;
  final Color color;
  final Widget frontChild;
  final Widget backChild;

  const SwipeableCardWidget({
    super.key,
    required this.height,
    required this.color,
    required this.frontChild,
    required this.backChild,
  });

  @override
  State<SwipeableCardWidget> createState() => _SwipeableCardWidgetState();
}

class _SwipeableCardWidgetState extends State<SwipeableCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _controller.addListener(() {
      if (_controller.value > 0.5) {
        setState(() {
          _isFrontVisible = false;
        });
      } else {
        setState(() {
          _isFrontVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swipe left
          _controller.forward();
        } else if (details.primaryVelocity! > 0) {
          // Swipe right
          _controller.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final value = _controller.value;

          return Transform(
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(value * 3.14),
            alignment: Alignment.center,
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(24),
              ),
              child:
                  _isFrontVisible
                      ? widget.frontChild
                      : Transform(
                        transform: Matrix4.identity()..rotateY(3.14),
                        alignment: Alignment.center,
                        child: widget.backChild,
                      ),
            ),
          );
        },
      ),
    );
  }
}
