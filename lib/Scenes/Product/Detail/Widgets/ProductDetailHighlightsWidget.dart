import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';

class ProductDetailHighlightsWidget extends StatelessWidget {
  final SectionModel section;

  const ProductDetailHighlightsWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 24.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: section.items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check, color: DSColors().primaryColor, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: DSText.compact(
                  item.title ?? '',
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
