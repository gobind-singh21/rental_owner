import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String _text;
  final double _fontSize;
  final TextOverflow? overflow;
  final Color? _color;
  const HeadingText(this._text, this._fontSize, this.overflow, this._color);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
        overflow: overflow,
        color: _color,
      ),
    );
  }
}
