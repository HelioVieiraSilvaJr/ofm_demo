import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Models/CartModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class CartProductItemWidget extends StatefulWidget {
  final CartProduct product;
  final void Function(int quantity)? onQuantityChanged;
  final VoidCallback? onRemove;

  const CartProductItemWidget({
    super.key,
    required this.product,
    this.onQuantityChanged,
    this.onRemove,
  });

  @override
  State<CartProductItemWidget> createState() => _CartProductItemWidgetState();
}

class _CartProductItemWidgetState extends State<CartProductItemWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }

  void _increase() {
    setState(() {
      quantity += 1;
    });
    widget.onQuantityChanged?.call(quantity);
  }

  void _decrease() {
    if (quantity <= 1) return;
    setState(() {
      quantity -= 1;
    });
    widget.onQuantityChanged?.call(quantity);
  }

  void _remove() {
    widget.onRemove?.call();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 95,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.thumbSKU,
                          cacheManager: CacheConfig.cacheManager,
                          placeholder: (context, url) => Center(
                            child: DSCustomCircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      if (product.tag != null)
                        Positioned(
                          left: 2,
                          bottom: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DSText.extraCompact(
                              product.tag!,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Controle de quantidade e lixeira
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: _decrease,
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.remove, size: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: DSText.medium('$quantity'),
                            ),
                            InkWell(
                              onTap: _increase,
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.add, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: _remove,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.delete_outline, size: 14),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // Informações do produto
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do produto
                    DSText.medium(
                      product.name,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 4),

                    // Tamanho
                    DSText.extraCompact(
                      'Maat: ${product.size}',
                      color: Colors.black,
                    ),

                    // Cor
                    DSText.extraCompact(
                      'Kleur: ${product.color ?? '-'}',
                      color: Colors.black,
                    ),

                    // SKU
                    DSText.extraCompact(
                      'Artikelnummer: ${product.sku}',
                      color: Colors.black,
                    ),
                    const SizedBox(height: 8),

                    // Preços
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (product.pricePromotional != null) ...[
                              DSText.compactWithDecoration(
                                '€ ${product.price}',
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                              DSText.medium(
                                '€ ${product.pricePromotional}',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ] else
                              DSText.medium(
                                '€ ${product.price}',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 10), height: 1, color: Colors.grey),
      ],
    );
  }
}
