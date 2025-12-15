import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class DSDoubleWideImagesWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const DSDoubleWideImagesWidget(
      {super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    final item1 = section.items.isNotEmpty ? section.items[0] : null;
    final item2 = section.items.length > 1 ? section.items[1] : null;
    const aspectRatio = 1.0;
    final imageUrl1 = item1?.imageUrl ?? 'https://placehold.co/150';
    final imageUrl2 = item2?.imageUrl ?? 'https://placehold.co/150';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: GestureDetector(
                  onTap: item1 != null ? () => onTap?.call(item1) : null,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl1,
                    cacheManager: CacheConfig.cacheManager,
                    placeholder: (context, url) =>
                        DSCustomCircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: GestureDetector(
                  onTap: item2 != null ? () => onTap?.call(item2) : null,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl2,
                    cacheManager: CacheConfig.cacheManager,
                    placeholder: (context, url) =>
                        DSCustomCircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
