import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class FloatingButton<T extends Iterable> extends StatelessWidget {
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

  bool get isDisabled => element.isEmpty;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: isDisabled ? null : onPressed,
      backgroundColor: isDisabled ? Colors.grey.shade600 : null,
      child: Icon(
        icon,
        color: isDisabled ? Colors.grey.shade300 : null,
      ),
    );
  }
}
