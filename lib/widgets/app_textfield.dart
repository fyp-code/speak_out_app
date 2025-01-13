import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.label,
    this.validator,
    this.keyboardType,
    this.textEditingController,
    this.suffixIcon,
    this.readOnly,
    this.prefix,
    this.obscureText,
    this.onCountryTap,
    BuildContext? context,
    this.onTap,
    this.textFieldUpperText,
    this.onSaved,
    this.onFieldSubmitted,
    this.autofillHints,
    this.initialValue,
    this.maxLines,
    this.maxLength,
    this.counterText,
    this.hintStyle,
    this.borderRadius,
    this.textKey,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
  });

  // final bool obscure;
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool? readOnly;
  final bool? obscureText;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? textEditingController;
  final VoidCallback? onCountryTap;
  final String? textFieldUpperText;
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final String? initialValue;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final Key? textKey;
  final TextInputAction textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    InputBorder getBorder(double width) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: width,
          color: Colors.black38,
        ),
      );
    }

    return TextFormField(
      textCapitalization: widget.textCapitalization,
      key: widget.textKey,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      autovalidateMode: widget.autovalidateMode,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.textEditingController,
      onSaved: widget.onSaved,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        prefix: widget.prefix,
        suffixIcon: widget.suffixIcon,
        border: getBorder(1),
        enabledBorder: getBorder(1),
        focusedBorder: getBorder(2),
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.black38,
        ),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.hint,
    this.label,
    this.validator,
    this.keyboardType,
    this.textEditingController,
    this.suffixIcon,
    this.readOnly,
    this.prefix,
    this.obscureText,
    this.onCountryTap,
    BuildContext? context,
    this.onTap,
    this.textFieldUpperText,
    this.onSaved,
    this.onFieldSubmitted,
    this.autofillHints,
    this.initialValue,
    this.maxLines,
    this.maxLength,
    this.counterText,
    this.hintStyle,
    this.borderRadius,
    this.textKey,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
  });

  // final bool obscure;
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool? readOnly;
  final bool? obscureText;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? textEditingController;
  final VoidCallback? onCountryTap;
  final String? textFieldUpperText;
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final String? initialValue;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final Key? textKey;
  final TextInputAction textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _show = true;
  InputBorder getBorder(double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.black38,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      key: widget.textKey,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      autovalidateMode: widget.autovalidateMode,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      obscureText: _show,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.textEditingController,
      onSaved: widget.onSaved,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        suffixIcon: GestureDetector(
          child: Icon(
            _show ? Icons.visibility_off : Icons.visibility,
          ),
          onTap: () => setState(
            () => _show = !_show,
          ),
        ),
        border: getBorder(1),
        enabledBorder: getBorder(1),
        focusedBorder: getBorder(2),
        labelText: widget.label,
        hintText: widget.hint,
      ),
    );
  }
}
