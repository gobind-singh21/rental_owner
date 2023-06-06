import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final List<String> _texts;

  const UnorderedList(this._texts, {super.key});

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in _texts) {
      widgetList.add(UnorderedListItem(text));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  final String text;

  const UnorderedListItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
