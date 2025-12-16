import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class DSBubblesWidget extends StatefulWidget {
  final SectionModel section;
  final Function(ItemModel) onTap;

  const DSBubblesWidget(
      {super.key, required this.section, required this.onTap});

  @override
  State<DSBubblesWidget> createState() => _DSBubblesWidgetState();
}

class _DSBubblesWidgetState extends State<DSBubblesWidget> {
  late final section = widget.section;
  late final onTap = widget.onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: section.items.length,
        itemBuilder: (context, index) {
          final item = section.items[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      cacheManager: CacheConfig.cacheManager,
                      placeholder: (context, url) =>
                          DSCustomCircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 8),
                  DSText.compact(
                    item.title ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
