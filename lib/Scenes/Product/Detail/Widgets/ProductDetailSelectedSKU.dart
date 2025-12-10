import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';

class ProductDetailSelectedSKU extends StatelessWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailSelectedSKU({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    final skus = presenter.viewModel.productModel.value?.productSKU ?? [];
    const size = 80.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: SizedBox(
        height: size,
        width: size,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: skus.length,
          itemBuilder: (context, index) {
            final sku = skus[index];
            final isSelected =
                presenter.viewModel.selectedSKU.value?.sku == sku.sku;
            return GestureDetector(
              onTap: () {
                presenter.handlerSetSKU(sku);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(
                            color: Colors.black,
                            width: 2.0,
                          )
                        : Border.all(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: sku.thumbSKU ?? '',
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      cacheManager: CacheConfig.cacheManager,
                      placeholder: (context, url) => Center(
                        child: CustomCircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
