import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';

class DSSectionAccordeonWidget extends StatefulWidget {
  final SectionModel section;

  const DSSectionAccordeonWidget({super.key, required this.section});

  @override
  State<DSSectionAccordeonWidget> createState() =>
      _DSSectionAccordeonWidgetState();
}

class _DSSectionAccordeonWidgetState extends State<DSSectionAccordeonWidget> {
  late final SectionModel section = widget.section;
  final ScrollController controller = ScrollController();
  final Set<int> _expandedItems = {};
  Function(String)? openLink;

  @override
  Widget build(BuildContext context) {
    const fontSizeTitle = 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: List.generate(section.items.length, (index) {
          final item = section.items[index];
          final isExpanded = _expandedItems.contains(index);

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
                bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedItems.remove(index);
                      } else {
                        _expandedItems.add(index);
                      }
                    });
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
                    child: Markdown(
                      controller: controller,
                      selectable: true,
                      shrinkWrap: true,
                      data: section.items.isNotEmpty ? item.text ?? '' : '',
                      onTapLink: (text, href, title) => {
                        if (href != null) openLink?.call(href),
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
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
