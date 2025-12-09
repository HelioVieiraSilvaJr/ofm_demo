import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';

class ShowcaseCategoriesWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const ShowcaseCategoriesWidget(
      {super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    final item1 = section.items.isNotEmpty ? section.items[0] : null;
    final item2 = section.items.length > 1 ? section.items[1] : null;
    final item3 = section.items.length > 2 ? section.items[2] : null;
    final item4 = section.items.length > 3 ? section.items[3] : null;
    const aspectRatio = 1.0;
    const double sizeSectionTitle = 18.0;
    const double sizeItemTitle = 16.0;
    const int blurItem = 100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              section.title ?? '',
              style: TextStyle(
                  fontSize: sizeSectionTitle,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
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
                            placeholder: (context, url) =>
                                CustomCircularProgressIndicator(),
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
                            child: Text(
                              item1?.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sizeItemTitle,
                                  fontWeight: FontWeight.bold),
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
                            placeholder: (context, url) =>
                                CustomCircularProgressIndicator(),
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
                            child: Text(
                              item2?.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sizeItemTitle,
                                  fontWeight: FontWeight.bold),
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
                            placeholder: (context, url) =>
                                CustomCircularProgressIndicator(),
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
                            child: Text(
                              item3?.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sizeItemTitle,
                                  fontWeight: FontWeight.bold),
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
                            placeholder: (context, url) =>
                                CustomCircularProgressIndicator(),
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
                            child: Text(
                              item4?.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sizeItemTitle,
                                  fontWeight: FontWeight.bold),
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
