import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

typedef ValidationFunction = String? Function(String? value);

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final double borderRadius;
  final IconData? suffixIcon;
  final bool isPassword;
  final ValidationFunction? validate;
  final TextEditingController controller;
  final int minLine;
  final int maxLine;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final ValidationFunction? onChanged;
  final ValidationFunction? onSubmit;
  // ignore: inference_failure_on_function_return_type
  final  Function()? onEditingComplete;
  final Color? color;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    required this.hintText,
    this.borderRadius = 10,
    this.suffixIcon,
    this.isPassword = false,
    this.validate,
    required this.controller,
    this.minLine = 1,
    this.maxLine = 1,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
    this.onSubmit,
    this.color,
    this.onEditingComplete,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return TextFormField(
      onEditingComplete: widget.onEditingComplete,
      onSaved: widget.onSubmit,
      onChanged: widget.onChanged,
      readOnly: widget.isReadOnly,
      keyboardType: widget.keyboardType,
      minLines: widget.minLine,
      maxLines: widget.maxLine,
      validator: widget.validate,
      controller: widget.controller,
      cursorColor: widget.color ?? AppColors.secondaryColor,
      decoration: InputDecoration(
        suffixIcon: (widget.isPassword == false)
            ? (widget.suffixIcon == null)
                ? null
                : Icon(
                    widget.suffixIcon,
                    color: widget.color,
                  )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  (isVisible)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
        hintText: widget.hintText,
        prefixIconColor: widget.color ?? AppColors.secondaryColor,
        suffixIconColor: widget.color ?? AppColors.secondaryColor,
        focusColor: widget.color ?? AppColors.secondaryColor,
        iconColor: widget.color ?? AppColors.secondaryColor,
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.color ?? Color(0xff677294), width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.color ?? Color(0xff677294), width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.color ?? Color(0xff677294), width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      style: theme.labelLarge?.copyWith(
            color: widget.color ?? AppColors.secondaryColor,
          ) ??
          TextStyle(
            fontSize: 16,
            color: widget.color ?? AppColors.secondaryColor,
          ),
      obscureText: (widget.isPassword) ? !isVisible : false,
    );
  }
}
