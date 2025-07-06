import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final IconData icon1;
  final IconData icon2;
  bool status;
  final Function(bool)? onToggle;

  SwitchButton({
    super.key,
    required this.status,
    required this.icon1,
    required this.icon2,
    this.onToggle,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {


  onClick() {
    setState(() {
      widget.status = !widget.status;
    });
    widget.onToggle?.call(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(widget.icon1, color: widget.status ? Colors.grey : Colors.orange),
        Switch(
          value: widget.status,
          onChanged: (_) => onClick(),
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.orange,
          inactiveTrackColor: Colors.orange.withAlpha(100),
        ),
        Icon(widget.icon2, color: widget.status ? Colors.blue : Colors.grey),
      ],
    );
  }
}
