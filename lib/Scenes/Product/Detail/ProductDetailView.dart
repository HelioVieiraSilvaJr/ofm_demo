import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/SectionType.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailListImagesWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailSelectedSizeWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseBubbleWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseContentMarkdown.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseDoubleWideImages.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseProductListHorizontalWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseWideImage.dart';
import 'package:ofm_demo/Sources/Base/BaseScreen.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ProductDetailView extends StatefulWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailView({super.key, required this.presenter});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late final presenter = widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: SingleChildScrollView(
          child: RxBuilder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductDetailListImagesWidget(
                    images:
                        presenter.viewModel.selectedSKU.value?.images ?? []),
                _buildDescription(),
                _buildSelectSKU(),
                ProductDetailSelectedSizeWidget(presenter: presenter),
                Column(
                    children:
                        (presenter.viewModel.productModel.value?.sections ?? [])
                            .map((section) {
                  switch (section.type) {
                    case SectionType.doubleWideImages:
                      return ShowcaseDoubleWideImages(
                          section: section,
                          onTap: presenter.handlerClickSectionItem);
                    case SectionType.wideImage:
                      return ShowcaseWideImage(
                          section: section,
                          onTap: presenter.handlerClickSectionItem);
                    case SectionType.bubbles:
                      return ShowcaseBubbleWidget(
                          section: section,
                          onTap: presenter.handlerClickSectionItem);
                    case SectionType.productListHorizontal:
                      return ShowcaseProductListHorizontalWidget(
                          section: section,
                          onTap: presenter.handlerClickSectionItem);
                    case SectionType.contentMarkdown:
                      return ShowcaseContentMarkdown(
                          section: section,
                          openLink: presenter.handlerOpenLink);
                    default:
                      return SizedBox.shrink();
                  }
                }).toList()),
              ],
            );
          }),
        ),
        presenter: presenter);
  }

  Widget _buildDescription() {
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

  Widget _buildSelectSKU() {
    final skus = presenter.viewModel.productModel.value?.productSKU ?? [];
    const height = 80.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: skus.length,
          itemBuilder: (context, index) {
            final sku = skus[index];
            return GestureDetector(
              onTap: () {
                presenter.handlerSetSKU(sku);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: sku.thumbSKU ?? '',
                    width: 70,
                    height: height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
