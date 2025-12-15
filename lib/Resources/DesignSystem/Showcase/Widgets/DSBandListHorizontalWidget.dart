import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';

class DSBandListHorizontalWidget extends StatelessWidget {
  final SectionModel section;
  const DSBandListHorizontalWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                section.title!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                section.items.length,
                (index) {
                  final item = section.items[index];
                  final isSvg = item.imageUrl.toLowerCase().endsWith('.svg');
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 8,
                      right: index == section.items.length - 1 ? 16 : 8,
                    ),
                    child: ClipRRect(
                      child: isSvg
                          ? SvgPicture.network(
                              item.imageUrl,
                              width: 40,
                              height: 24,
                              fit: BoxFit.contain,
                              placeholderBuilder: (context) => Container(
                                width: 40,
                                height: 24,
                                color: Colors.grey[200],
                              ),
                            )
                          : Image.network(
                              item.imageUrl,
                              width: 48,
                              height: 32,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 48,
                                height: 32,
                                color: Colors.grey[200],
                                child: const Icon(Icons.error, size: 20),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
