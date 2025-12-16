import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class DSProductCardWidget extends StatelessWidget {
  final ItemModel item;
  final Function(ItemModel)? onTap;

  const DSProductCardWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1) Imagem com tag de frete grátis
            Flexible(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      cacheManager: CacheConfig.cacheManager,
                      placeholder: (context, url) => Center(
                        child: DSCustomCircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    // 2) Tag "Frete grátis" em cima da imagem, alinhado embaixo
                    if (item.tag != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: DSText.extraCompact(
                            item.tag ?? '',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Container para título e preço
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 3) Título do produto
                  DSText.compact(
                    item.title ?? 'Produto sem nome',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 4),
                  // 4) Preço promocional e preço original
                  Row(
                    children: [
                      if (item.pricePromotional != null)
                        Row(
                          children: [
                            DSText.medium(
                              item.pricePromotional!,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      Flexible(
                        child: DSText.mediumWithDecoration(
                          item.price ?? '€ 0,00',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: item.pricePromotional != null
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
