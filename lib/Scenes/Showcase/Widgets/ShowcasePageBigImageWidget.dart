import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class ShowcasePageBigImageWidget extends StatelessWidget {
  final SectionModel section;
  final Function(ItemModel) onTap;

  const ShowcasePageBigImageWidget(
      {super.key, required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (section.items.isNotEmpty) {
          onTap(section.items[0]);
        }
      },
      child: CachedNetworkImage(
        imageUrl: section.items.isNotEmpty ? section.items[0].imageUrl : '',
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
