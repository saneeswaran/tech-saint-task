import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final Widget? suffixIcon;
  final String labelText;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.suffixIcon,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            Icons.search,
            color: theme.iconTheme.color?.withOpacity(0.5),
          ),
          suffixIcon: suffixIcon,
          hintText: "Search here...",
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
