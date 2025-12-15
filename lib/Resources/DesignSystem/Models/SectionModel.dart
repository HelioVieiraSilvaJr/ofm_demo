import 'package:ofm_demo/Resources/DesignSystem/Enums/SectionType.dart';

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

  factory SectionModel.fromJson(Map<String, dynamic> data) {
    List<dynamic> itemsList = data['items'] ?? [];
    List<ItemModel> items =
        itemsList.map((item) => ItemModel.fromJson(item)).toList();

    final model = SectionModel(
      type: SectionTypeExtension.unwrapped(data['type']),
      title: data['title'],
      items: items,
    );
    return model;
  }

  toJson() {
    return {
      'type': type.rawValue,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SectionModel(type: ${type.rawValue}, items: $items)';
  }
}
