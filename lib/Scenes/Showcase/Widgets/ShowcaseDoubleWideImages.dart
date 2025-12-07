import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class ShowcaseDoubleWideImages extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const ShowcaseDoubleWideImages(
      {super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    final item1 = section.items.isNotEmpty ? section.items[0] : null;
    final item2 = section.items.length > 1 ? section.items[1] : null;
    const aspectRatio = 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                    imageUrl: item1?.imageUrl ?? 'https://placehold.co/150',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                    imageUrl: item2?.imageUrl ?? 'https://placehold.co/150',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
