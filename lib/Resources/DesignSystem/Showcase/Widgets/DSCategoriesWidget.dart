import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class DSCategoriesWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const DSCategoriesWidget({super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    final item1 = section.items.isNotEmpty ? section.items[0] : null;
    final item2 = section.items.length > 1 ? section.items[1] : null;
    final item3 = section.items.length > 2 ? section.items[2] : null;
    final item4 = section.items.length > 3 ? section.items[3] : null;
    const aspectRatio = 1.0;
    const int blurItem = 100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: DSText.large(
              section.title ?? '',
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: GestureDetector(
                      onTap: item1 != null ? () => onTap?.call(item1) : null,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                item1?.imageUrl ?? 'https://placehold.co/150',
                            cacheManager: CacheConfig.cacheManager,
                            placeholder: (context, url) =>
                                DSCustomCircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withAlpha(blurItem),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: DSText.large(
                              item1?.title ?? '',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: GestureDetector(
                      onTap: item2 != null ? () => onTap?.call(item2) : null,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                item2?.imageUrl ?? 'https://placehold.co/150',
                            cacheManager: CacheConfig.cacheManager,
                            placeholder: (context, url) =>
                                DSCustomCircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withAlpha(blurItem),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: DSText.large(
                              item2?.title ?? '',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: GestureDetector(
                      onTap: item3 != null ? () => onTap?.call(item3) : null,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                item3?.imageUrl ?? 'https://placehold.co/150',
                            cacheManager: CacheConfig.cacheManager,
                            placeholder: (context, url) =>
                                DSCustomCircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withAlpha(blurItem),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: DSText.large(
                              item3?.title ?? '',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: GestureDetector(
                      onTap: item4 != null ? () => onTap?.call(item4) : null,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                item4?.imageUrl ?? 'https://placehold.co/150',
                            cacheManager: CacheConfig.cacheManager,
                            placeholder: (context, url) =>
                                DSCustomCircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withAlpha(blurItem),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: DSText.large(
                              item4?.title ?? '',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
