import 'ItemModel.dart';

class SectionModel {
  final SectionType type;
  final String? title;
  final List<ItemModel> items;

  SectionModel({
    required this.type,
    this.title,
    required this.items,
  });

  factory SectionModel.initFromMap({required Map<String, dynamic> data}) {
    List<dynamic> itemsList = data['items'] ?? [];
    List<ItemModel> items =
        itemsList.map((e) => ItemModel.initFromMap(data: e)).toList();

    final model = SectionModel(
      type: SectionTypeExtension.unwrapped(data['type']),
      title: data['title'],
      items: items,
    );
    return model;
  }

  toJSON() {
    return {
      'type': type.rawValue,
      'items': items.map((e) => e.toJSON()).toList(),
    };
  }

  @override
  String toString() {
    return 'SectionModel(type: ${type.rawValue}, items: $items)';
  }
}

enum SectionType {
  pageBigImage,
  singleWideImage,
  listSmallImage,
  categories,
  listWideImage,
  bubbles,
  listServices,
  none;
}

extension SectionTypeExtension on SectionType {
  String get rawValue {
    switch (this) {
      case SectionType.pageBigImage:
        return 'pageBigImage';
      case SectionType.singleWideImage:
        return 'singleWideImage';
      case SectionType.listSmallImage:
        return 'listSmallImage';
      case SectionType.categories:
        return 'categories';
      case SectionType.listWideImage:
        return 'listWideImage';
      case SectionType.bubbles:
        return 'bubbles';
      case SectionType.listServices:
        return 'listServices';
      case SectionType.none:
        return 'none';
    }
  }

  String get value {
    switch (this) {
      case SectionType.pageBigImage:
        return 'Page Big Image';
      case SectionType.singleWideImage:
        return 'Single Wide Image';
      case SectionType.listSmallImage:
        return 'List Small Image';
      case SectionType.categories:
        return 'Categories';
      case SectionType.listWideImage:
        return 'List Wide Image';
      case SectionType.bubbles:
        return 'Bubbles';
      case SectionType.listServices:
        return 'List Services';
      case SectionType.none:
        return 'None';
    }
  }

  static List<SectionType> getList() {
    return SectionType.values;
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
