import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class FloatingButton<T> extends StatelessWidget {
  final String heroTag;
  final T element;
  final Callback onPressed;
  final IconData icon;

  const FloatingButton({
    super.key,
    required this.element,
    required this.heroTag,
    required this.onPressed,
    required this.icon,
  });

  bool get isDisabled {
    if (element is Iterable) {
      return (element as Iterable).isEmpty;
    }
    return element == null;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "Clear",
      onPressed: isDisabled ? null : onPressed,
      backgroundColor: isDisabled ? Colors.grey.shade600 : null,
      child: Icon(
        icon,
        color: isDisabled ? Colors.grey.shade300 : null,
      ),
    );
  }
}
