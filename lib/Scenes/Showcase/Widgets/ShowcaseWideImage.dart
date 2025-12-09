import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';

class ShowcaseWideImage extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel)? onTap;
  const ShowcaseWideImage({super.key, required this.section, this.onTap});

  @override
  Widget build(BuildContext context) {
    final item1 = section.items.isNotEmpty ? section.items[0] : null;
    const aspectRatio = 1.7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: GestureDetector(
            onTap: item1 != null ? () => onTap?.call(item1) : null,
            child: CachedNetworkImage(
              imageUrl: item1?.imageUrl ?? 'https://placehold.co/150',
              placeholder: (context, url) => CustomCircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
