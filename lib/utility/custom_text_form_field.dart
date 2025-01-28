import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool? obsecureText;
  final bool isRequired; // Parameter baru
  final TextInputAction? textInputAction;
  final Function(String value)? onFieldSubmitted;
  final TextInputType? textInputType;
  final bool enabled;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.title,
      this.obsecureText,
      this.textInputAction,
      this.onFieldSubmitted,
      this.textInputType,
      this.enabled = true,
      this.isRequired = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool? obsecureText;
  @override
  void initState() {
    obsecureText = widget.obsecureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title),
        7.verticalSpacingRadius,
        TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: obsecureText != null ? obsecureText! : false,
          validator: widget.isRequired // Tambahkan validator jika isRequired true
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "${widget.title} is required.";
                  }
                  return null;
                }
              : null,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
              fillColor: widget.enabled ? "#F5F5F5".toColor() : Colors.grey.shade300,
              filled: true,
              suffixIcon: obsecureText == null
                  ? null
                  : obsecureText!
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              obsecureText = !obsecureText!;
                            });
                          },
                          icon: Icon(Icons.visibility_off_outlined))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              obsecureText = !obsecureText!;
                            });
                          },
                          icon: Icon(Icons.visibility_outlined)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: '#696969'.toColor().withValues(alpha: 0.26))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 1.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: '#696969'.toColor().withValues(alpha: 0.26)))),
        )
      ],
    );
  }
}
