import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class ProductDetailHighlightsWidget extends StatelessWidget {
  final SectionModel section;

  const ProductDetailHighlightsWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: section.items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check, color: Colors.green),
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
