import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class ShowcasePageBigImageWidget extends StatelessWidget {
  final SectionModel section;
  final Function(SectionModel) onTap;

  const ShowcasePageBigImageWidget(
      {super.key, required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(section);
      },
      child: CachedNetworkImage(
        imageUrl: section.imageUrl ?? '',
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
