import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/helper.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
              text: widget.text, style: widget.style ?? DefaultTextStyle.of(context).style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final bool isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isExpanded ? widget.text : widget.text,
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: widget.style,
            ),
            if (isOverflowing)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? context.l10n.show_less : context.l10n.see_all,
                    style:
                        TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
