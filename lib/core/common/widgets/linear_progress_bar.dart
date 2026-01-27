import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExpressiveProgressIndicator extends StatefulWidget {
  const ExpressiveProgressIndicator({
    required this.value,
    super.key,
    this.height = 30.0,
    this.activeColor = const Color(0xFF8D5358), // Dark reddish-brown from image
    this.inactiveColor = const Color(0xFFF4DCDD), // Light pink from image
    this.strokeWidth = 10.0,
    this.animateWave = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.gap = 4,
  });
  final double value; // 0.0 to 1.0
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;
  final bool animateWave;
  final Duration animationDuration;
  final double gap;

  @override
  State<ExpressiveProgressIndicator> createState() =>
      _ExpressiveProgressIndicatorState();
}

class _ExpressiveProgressIndicatorState
    extends State<ExpressiveProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.animateWave) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ExpressiveProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle toggling animation on/off dynamically
    if (widget.animateWave != oldWidget.animateWave) {
      if (widget.animateWave) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    // Handle speed changes
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
      if (widget.animateWave) _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SquigglySliderPainter(
              progress: widget.value.clamp(0.0, 1.0),
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
              strokeWidth: widget.strokeWidth,
              animationValue: _controller.value,
              amplitude: widget.height / 4, // Wave height
              wavelength: 40, // Distance between peaks
              gap: widget.gap,
            ),
          );
        },
      ),
    );
  }
}

class _SquigglySliderPainter extends CustomPainter {
  _SquigglySliderPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
    required this.animationValue,
    required this.amplitude,
    required this.wavelength,
    required this.gap,
  });
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;
  final double animationValue;
  final double amplitude;
  final double wavelength;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color =
          activeColor // The tiny dot at the very end
      ..style = PaintingStyle.fill;

    final midHeight = size.height / 2;
    final activeWidth = size.width * progress;

    // --- 1. Draw Inactive Track (Right Side) ---
    // Simple straight line from activeWidth to end
    if (progress < 1.0) {
      final inactivePath = Path()
        // Start slightly after the active part to prevent overlap glitches
        ..moveTo(activeWidth + strokeWidth + gap, midHeight)
        ..lineTo(size.width, midHeight);
      canvas
        ..drawPath(inactivePath, inactivePaint)
        // Draw the small dot at the very end of the track as seen in the image
        ..drawCircle(
          Offset(size.width, midHeight),
          strokeWidth / 4,
          dotPaint,
        );
    }

    // --- 2. Draw Active Squiggly Line (Left Side) ---
    if (progress > 0.0) {
      final wavePath = Path();
      var isFirstPoint = true;

      // We draw the sine wave point by point for the active width
      for (var x = 0.0; x <= activeWidth; x++) {
        // Math: y = Amplitude * sin( (2*pi*x / wavelength) - phaseShift )
        // The phase shift creates the animation movement
        final phaseShift = animationValue * 2 * math.pi;
        final y =
            midHeight +
            amplitude * math.sin((2 * math.pi * x / wavelength) - phaseShift);

        if (isFirstPoint) {
          // DYNAMIC START: Move to the calculated Y of the first pixel
          // This ensures the start aligns with the wave phase
          wavePath.moveTo(x, y);
          isFirstPoint = false;
        } else {
          wavePath.lineTo(x, y);
        }
      }

      canvas.drawPath(wavePath, activePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SquigglySliderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.activeColor != activeColor;
  }
}
