import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class ShowcaseContentMarkdown extends StatelessWidget {
  final SectionModel section;
  final Function(String) openLink;
  final ScrollController controller = ScrollController();

  ShowcaseContentMarkdown(
      {super.key, required this.section, required this.openLink});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      controller: controller,
      selectable: true,
      shrinkWrap: true,
      data: section.items.isNotEmpty ? section.items[0].text ?? '' : '',
      onTapLink: (text, href, title) => {
        if (href != null) openLink(href),
      },
      styleSheet: MarkdownStyleSheet(
        a: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
        ),
        h1: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        h2: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        h3: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
