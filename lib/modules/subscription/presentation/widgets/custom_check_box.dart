import 'package:flutter/material.dart';
import 'package:subsciption_manager/config/constants/colors.dart';

class CustomCheckbox extends StatefulWidget {
  final Function(bool) onChanged;

  const CustomCheckbox({
    super.key,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => _isChecked = !_isChecked);
        widget.onChanged.call(_isChecked);
      },
      child: Container(
        width: 26.0,
        height: 26.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isChecked ? AppColors.blue : Colors.black,
        ),
        child: _isChecked
            ? const Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
