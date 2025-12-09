import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DSColors.dart';

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
                child: Text(
                  item.title ?? '',
                  style: TextStyle(fontSize: 12),
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
