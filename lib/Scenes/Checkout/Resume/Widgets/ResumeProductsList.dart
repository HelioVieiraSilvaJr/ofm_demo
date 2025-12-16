import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Models/ResumeModel.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class ResumeProductsList extends StatelessWidget {
  final List<ResumeProduct> products;

  const ResumeProductsList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Producten in je bestelling',
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: products
                .asMap()
                .entries
                .map((entry) => _buildProductItem(
                      entry.value,
                      isLast: entry.key == products.length - 1,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(ResumeProduct product, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            // borderRadius: BorderRadius.circular(2),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              cacheManager: CacheConfig.cacheManager,
              width: 30,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 30,
                height: 40,
                color: Colors.grey.shade200,
                child: Center(
                  child: DSCustomCircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, error, stackTrace) => Container(
                width: 30,
                height: 40,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Name
          Expanded(
            child: DSText.medium(
              product.name,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          // Quantity
          DSText.medium(
            '${product.quantity}x',
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
