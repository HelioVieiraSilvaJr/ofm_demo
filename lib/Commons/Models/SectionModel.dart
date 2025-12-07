import 'package:ofm_demo/Commons/Enums/SectionType.dart';

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


