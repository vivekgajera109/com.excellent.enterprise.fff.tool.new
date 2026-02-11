// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import 'validator.dart';

/// ------------------------------------------------------------
/// SEARCH FIELD
/// ------------------------------------------------------------
Widget searchTextFormField(
  BuildContext context, {
  String? hintText,
  TextEditingController? controller,
  ValueChanged<String?>? onChanged,
  VoidCallback? searchOnTap,
  FocusNode? focusNode,
}) {
  return textFormField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText ?? "Search",
    prefixIcon: const Icon(
      CupertinoIcons.search,
      color: AppColors.textSecondary,
    ),
    suffixIcon: IconButton(
      icon: const Icon(Icons.arrow_forward_ios_rounded),
      color: AppColors.accent,
      onPressed: searchOnTap,
    ),
    onChanged: onChanged,
  );
}

/// ------------------------------------------------------------
/// EMAIL FIELD
/// ------------------------------------------------------------
class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.enabled,
  });

  final TextEditingController controller;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      controller: controller,
      hintText: hintText ?? "Email address",
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      enabled: enabled,
      textInputAction: textInputAction,
      validator:
          validator ?? (value) => Validators.validateEmail(value?.trim() ?? ""),
    );
  }
}

/// ------------------------------------------------------------
/// PASSWORD FIELD
/// ------------------------------------------------------------
class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String?>? validator;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      controller: widget.controller,
      hintText: widget.hintText ?? "Password",
      obscureText: _obscure,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
      validator: widget.validator ??
          (value) => Validators.validateRequired(value!.trim(), "Password"),
    );
  }
}

/// ------------------------------------------------------------
/// NUMBER FIELD
/// ------------------------------------------------------------
class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLength,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final int? maxLength;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      controller: controller,
      hintText: hintText ?? "Enter number",
      keyboardType: TextInputType.number,
      maxLength: maxLength,
      validator: validator,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

/// ------------------------------------------------------------
/// TEXT AREA
/// ------------------------------------------------------------
class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLines = 4,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final int maxLines;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      controller: controller,
      hintText: hintText ?? "Write here...",
      maxLines: maxLines,
      validator: validator,
    );
  }
}

/// ------------------------------------------------------------
/// CORE PREMIUM DARK TEXT FIELD
/// ------------------------------------------------------------
Widget textFormField({
  Key? fieldKey,
  String? hintText,
  String? labelText,
  String? helperText,
  int? maxLines = 1,
  int? maxLength,
  bool? enabled = true,
  bool autofocus = false,
  bool obscureText = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  FocusNode? focusNode,
  TextEditingController? controller,
  List<TextInputFormatter>? inputFormatters,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  GestureTapCallback? onTap,
  FormFieldValidator<String?>? validator,
  ValueChanged<String?>? onChanged,
  ValueChanged<String?>? onFieldSubmitted,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.divider, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: TextFormField(
      key: fieldKey,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      cursorColor: AppColors.accent,
      style: AppTextStyle.regular16,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.transparent,
        counterText: "",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: hintText,
        hintStyle: AppTextStyle.regular14.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        errorStyle: AppTextStyle.error14,
        labelText: labelText,
        helperText: helperText,
      ),
    ),
  );
}
