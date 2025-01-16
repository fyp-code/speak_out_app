import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.onChanged,
    required this.dropItems,
    this.borderRadius,
    this.dropIconColor,
    this.dropdownColor,
    this.padding,
    this.validator,
    this.icon,
    required this.value,
  });
  final void Function(String?)? onChanged;
  final List<String> dropItems;
  final double? borderRadius;
  final double? padding;
  final Color? dropIconColor;
  final Color? dropdownColor;
  final Widget? icon;
  final String value;

  final String? Function(String?)? validator;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String selectedDropItem;

  @override
  void initState() {
    super.initState();
    selectedDropItem =
        widget.value.isEmpty ? widget.dropItems.first : widget.value;
  }

  InputBorder getBorder(double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      borderSide: BorderSide(
        width: width,
        color: Colors.black38,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          iconEnabledColor: widget.dropIconColor ?? Colors.black,
          value: selectedDropItem,
          isExpanded: true,
          isDense: true,
          icon: widget.icon,
          decoration: InputDecoration(
            border: getBorder(1),
            enabledBorder: getBorder(1),
            focusedBorder: getBorder(2),
            filled: false,
          ),
          dropdownColor: widget.dropdownColor ?? Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          items: widget.dropItems.map(
            (String e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ).toList(),
          validator: widget.validator,
          onChanged: (String? v) {
            selectedDropItem = v!;
            setState(() {});
            widget.onChanged!(v);
          },
        ),
      ),
    );
  }
}
