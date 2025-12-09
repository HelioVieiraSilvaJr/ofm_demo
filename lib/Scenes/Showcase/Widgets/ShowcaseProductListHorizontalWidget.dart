import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Commons/Widgets/ProductCardWidget.dart';

class ShowcaseProductListHorizontalWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const ShowcaseProductListHorizontalWidget(
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
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                section.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: section.items.length,
              itemBuilder: (context, index) {
                final item = section.items[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == section.items.length - 1 ? 16 : 4,
                  ),
                  child: SizedBox(
                    width: 160,
                    child: ProductCardWidget(item: item, onTap: onTap),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
