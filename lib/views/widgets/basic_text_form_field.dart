import 'package:flutter/material.dart';
import 'package:dsw52703/utils/colors.dart';

class TextFormFieldWithIcon extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFormFieldWithIcon({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });

  @override
  State<TextFormFieldWithIcon> createState() => _TextFormFieldWithIconState();
}

class _TextFormFieldWithIconState extends State<TextFormFieldWithIcon> {
  /// Kontrolujemy lokalnie widoczność hasła, jeśli `obscureText = true`.
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      validator: widget.validator,
      style: TextStyle(
        color: MyColors.blackColor.withOpacity(0.3),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: MyColors.blackColor.withOpacity(0.3),
        ),
        prefixIcon: Icon(widget.icon, size: 30),
        // Ikonka do włączania/wyłączania widoczności hasła,
        // tylko jeśli pole ma być zasłaniane.
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MyColors.purpleColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MyColors.purpleColor, width: 2),
        ),
      ),
    );
  }
}
