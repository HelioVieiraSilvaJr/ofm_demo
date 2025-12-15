import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Enums/SectionType.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/ItemModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSBandListHorizontalWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSBigImageWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSBubblesWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCategoriesWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSContentMarkdownWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSDoubleWideImagesWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSProductGridWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSProductListHorizontalWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSSectionAccordeonWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSWideImageWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailHighlightsWidget.dart';

class DSShowcaseWidget extends StatelessWidget {
  final List<SectionModel> sections;
  final Function(ItemModel) handlerClickSectionItem;
  final Function(String?) handlerOpenLink;

  const DSShowcaseWidget(
      {super.key,
      required this.sections,
      required this.handlerClickSectionItem,
      required this.handlerOpenLink});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections.map((section) {
      switch (section.type) {
        case SectionType.bigImage:
          return DSBigImageWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.doubleWideImages:
          return DSDoubleWideImagesWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.wideImage:
          return DSWideImageWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.categories:
          return DSCategoriesWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.bubbles:
          return DSBubblesWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.productList:
          return DSProductGridWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.productListHorizontal:
          return DSProductListHorizontalWidget(
              section: section, onTap: handlerClickSectionItem);
        case SectionType.contentMarkdown:
          return DSContentMarkdownWidget(
              section: section, openLink: handlerOpenLink);
        case SectionType.bandListHorizontal:
          return DSBandListHorizontalWidget(section: section);   
        case SectionType.highlights:
          return ProductDetailHighlightsWidget(section: section);
        case SectionType.accordion:
          return DSSectionAccordeonWidget(section: section);
        default:
          return SizedBox.shrink();
      }
    }).toList());
  }
}
