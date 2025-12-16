import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSProductCardWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';

class DSProductListHorizontalWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const DSProductListHorizontalWidget(
      {super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: DSText.large(
                section.title!,
                fontWeight: FontWeight.bold,
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                section.items.length,
                (index) {
                  final item = section.items[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 4,
                      right: index == section.items.length - 1 ? 16 : 4,
                    ),
                    child: SizedBox(
                      width: 160,
                      height: 280,
                      child: DSProductCardWidget(item: item, onTap: onTap),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
