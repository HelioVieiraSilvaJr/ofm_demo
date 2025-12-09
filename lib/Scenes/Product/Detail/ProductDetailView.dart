import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/SectionType.dart';
import 'package:ofm_demo/Commons/Widgets/SectionAccordeonWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailDescription.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailHighlightsWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailListImagesWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailSelectedSKU.dart';
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
                ProductDetailDescription(presenter: presenter),
                ProductDetailSelectedSKU(presenter: presenter),
                ProductDetailSelectedSizeWidget(presenter: presenter),
                _buildSections()
              ],
            );
          }),
        ),
        presenter: presenter);
  }

  Widget _buildSections() {
    return Column(
        children: (presenter.viewModel.productModel.value?.sections ?? [])
            .map((section) {
      switch (section.type) {
        case SectionType.doubleWideImages:
          return ShowcaseDoubleWideImages(
              section: section, onTap: presenter.handlerClickSectionItem);
        case SectionType.wideImage:
          return ShowcaseWideImage(
              section: section, onTap: presenter.handlerClickSectionItem);
        case SectionType.bubbles:
          return ShowcaseBubbleWidget(
              section: section, onTap: presenter.handlerClickSectionItem);
        case SectionType.productListHorizontal:
          return ShowcaseProductListHorizontalWidget(
              section: section, onTap: presenter.handlerClickSectionItem);
        case SectionType.contentMarkdown:
          return ShowcaseContentMarkdown(
              section: section, openLink: presenter.handlerOpenLink);
        case SectionType.highlights:
          return ProductDetailHighlightsWidget(section: section);
        case SectionType.accordion:
          return SectionAccordeonWidget(section: section);
        default:
          return SizedBox.shrink();
      }
    }).toList());
  }
}
