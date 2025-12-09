import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';

class ShowcaseBubbleWidget extends StatefulWidget {
  final SectionModel section;
  final Function(ItemModel) onTap;

  const ShowcaseBubbleWidget(
      {super.key, required this.section, required this.onTap});

  @override
  State<ShowcaseBubbleWidget> createState() => _ShowcaseBubbleWidgetState();
}

class _ShowcaseBubbleWidgetState extends State<ShowcaseBubbleWidget> {
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
                      placeholder: (context, url) =>
                          CustomCircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.title ?? '',
                    style: TextStyle(fontSize: 12),
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
