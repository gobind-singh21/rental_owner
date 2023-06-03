import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String _text;
  final double _fontSize;
  final TextOverflow? _textOverflow;
  final Color _color;
  const NormalText(this._text, this._fontSize, this._textOverflow, this._color);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: _fontSize,
        overflow: _textOverflow,
        color: _color,
      ),
    );
  }
}
