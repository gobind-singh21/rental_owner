import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final List<String> _texts;

  UnorderedList(this._texts);

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in _texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  final String text;

  UnorderedListItem(this.text);

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
