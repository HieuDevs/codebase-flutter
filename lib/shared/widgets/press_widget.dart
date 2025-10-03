import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lua/shared/resources/values.dart';

class PressWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final double? scaleWhenPressed;
  final double? opacityWhenPressed;
  final Duration? duration;
  final Curve? curve;
  final bool enableHaptic;
  final bool disabled;

  const PressWidget({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.scaleWhenPressed,
    this.opacityWhenPressed,
    this.duration,
    this.curve,
    this.enableHaptic = true,
    this.disabled = false,
    super.key,
  });

  @override
  State<PressWidget> createState() => _PressWidgetState();
}

class _PressWidgetState extends State<PressWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 100),
    );

    final scale = widget.scaleWhenPressed ?? 0.95;
    final opacity = widget.opacityWhenPressed ?? 0.8;
    final curve = widget.curve ?? Curves.easeInOut;

    _scaleAnimation = Tween<double>(
      begin: AppValues.s1,
      end: scale,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));

    _opacityAnimation = Tween<double>(
      begin: AppValues.s1,
      end: opacity,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.disabled) {
      _controller.forward();
      if (widget.enableHaptic) {
        HapticFeedback.lightImpact();
      }
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.disabled) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (!widget.disabled) {
      _controller.reverse();
    }
  }

  void _onTap() {
    if (!widget.disabled && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  void _onLongPress() {
    if (!widget.disabled && widget.onLongPress != null) {
      if (widget.enableHaptic) {
        HapticFeedback.mediumImpact();
      }
      widget.onLongPress!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      onLongPress: widget.onLongPress != null ? _onLongPress : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(scale: _scaleAnimation.value, child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}
