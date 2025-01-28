import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class CustomSelectField<T> extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool? obsecureText;
  final bool isRequired; // Parameter baru
  final TextInputAction? textInputAction;
  final Function(String value)? onFieldSubmitted;
  final T selected;
  final Function(dynamic value) onSelect;
  final List<T> options;
  final FocusNode? focusNode;
  const CustomSelectField(
      {super.key,
      required this.controller,
      required this.title,
      this.obsecureText,
      this.textInputAction,
      this.onFieldSubmitted,
      required this.selected,
      required this.onSelect,
      required this.options,
      this.focusNode,
      this.isRequired = false});

  @override
  State<CustomSelectField> createState() => _CustomSelectFieldState<T>();
}

class _CustomSelectFieldState<T> extends State<CustomSelectField> {
  bool? obsecureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    obsecureText = widget.obsecureText;
    _focusNode = widget.focusNode ?? FocusNode();
    if (_focusNode.hasFocus) {
      showBottomdialog();
    }
    super.initState();
  }

  void showBottomdialog() {
    showBlurredBottomSheet(
      context: context,
      builder: (context) => BlurContainerWrapper(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpacingRadius,
            Text(
              "Please select",
              style: bebasNeue.copyWith(fontSize: 24.spMin),
            ),
            5.verticalSpacingRadius,
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: widget.selected == widget.options[index],
                  title: Text(widget.options[index]),
                  onChanged: (value) {
                    widget.onSelect(widget.options[index]);
                  },
                );
              },
            )
          ],
        ),
      )),
    );
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
          showCursor: false,
          onTap: showBottomdialog,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
              fillColor: "#F5F5F5".toColor(),
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
