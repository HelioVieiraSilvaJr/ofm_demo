enum SectionType {
  bigImage,
  wideImage,
  doubleWideImages,
  categories,
  listWideImage,
  bubbles,
  contentMarkdown,
  productList,
  productListHorizontal,
  accordion,
  highlights,
  bandListHorizontal,
  none;
}

extension SectionTypeExtension on SectionType {
  String get rawValue {
    switch (this) {
      case SectionType.bigImage:
        return 'bigImage';
      case SectionType.wideImage:
        return 'wideImage';
      case SectionType.doubleWideImages:
        return 'doubleWideImages';
      case SectionType.categories:
        return 'categories';
      case SectionType.listWideImage:
        return 'listWideImage';
      case SectionType.bubbles:
        return 'bubbles';
      case SectionType.contentMarkdown:
        return 'contentMarkdown';
      case SectionType.productList:
        return 'productList';
      case SectionType.productListHorizontal:
        return 'productListHorizontal';
      case SectionType.accordion:
        return 'accordion';
      case SectionType.highlights:
        return 'highlights';
      case SectionType.bandListHorizontal:
        return 'bandListHorizontal';
      case SectionType.none:
        return 'none';
    }
  }

  static SectionType unwrapped(String? key) {
    var status = SectionType.none;
    if (key != null) {
      try {
        status = SectionType.values.firstWhere(
          (value) => value.toString() == 'SectionType.$key',
          orElse: () => SectionType.none,
        );
      } catch (_) {}
    }
    return status;
  }
}
