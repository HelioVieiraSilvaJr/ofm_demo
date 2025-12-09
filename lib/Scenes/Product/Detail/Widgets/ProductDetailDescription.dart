import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';

class ProductDetailDescription extends StatelessWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailDescription({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    final product = presenter.viewModel.productModel.value;
    const fontSizeTitle = 18.0;
    const fontSizePrices = 16.0;
    const fontSizeTag = 14.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3) Título do produto
          Text(
            product?.title ?? '-?-',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSizeTitle,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // 4) Preço promocional e preço original
          Row(children: [
            if (product?.pricePromotional != null)
              Row(
                children: [
                  Text(
                    product!.pricePromotional!,
                    style: TextStyle(
                      fontSize: fontSizePrices,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            Text(
              product?.price ?? 'R\$ 0,00',
              style: TextStyle(
                fontSize: fontSizePrices,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: product?.pricePromotional != null
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ]),
          const SizedBox(height: 8),
          if (product?.tag != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                product?.tag ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeTag,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
