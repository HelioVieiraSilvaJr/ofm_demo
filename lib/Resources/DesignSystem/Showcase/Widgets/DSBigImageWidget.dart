import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class DSBigImageWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel) onTap;

  const DSBigImageWidget(
      {super.key, required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = section.items.isNotEmpty ? section.items[0].imageUrl : '';
    return GestureDetector(
      onTap: () {
        if (section.items.isNotEmpty) {
          onTap(section.items[0]);
        }
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        cacheKey: imageUrl,
        cacheManager: CacheConfig.cacheManager,
        placeholder: (context, url) =>
            Center(child: DSCustomCircularProgressIndicator()),
        errorWidget: (context, url, error) {
          return Icon(Icons.error);
        },
      ),
    );
  }
}
