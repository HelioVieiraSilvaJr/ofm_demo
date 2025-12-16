import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';

class ProductDetailDescription extends StatelessWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailDescription({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    final product = presenter.viewModel.productModel.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3) Título do produto
          DSText.large(
            product?.title ?? '',
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          const SizedBox(height: 4),
          // 4) Preço promocional e preço original
          Row(children: [
            if (product?.pricePromotional != null)
              Row(
                children: [
                  DSText.large(
                    product!.pricePromotional!,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            DSText.largeWithDecoration(
              product?.price ?? '',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: product?.pricePromotional != null
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ]),
          const SizedBox(height: 8),
          if (product?.tag != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: DSText.medium(
                product?.tag ?? '',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
