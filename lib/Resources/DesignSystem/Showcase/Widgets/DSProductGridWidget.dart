import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSProductCardWidget.dart';

class DSProductGridWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const DSProductGridWidget({super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: section.items.length,
      itemBuilder: (context, index) {
        final item = section.items[index];
        return SizedBox(
          child: DSProductCardWidget(item: item, onTap: onTap),
        );
      },
    );
  }
}
