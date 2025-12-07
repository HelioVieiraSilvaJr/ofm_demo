import 'package:ofm_demo/Commons/Enums/ActionType.dart';

class ItemModel {
  final String imageUrl;
  final String? title;
  final String? text;
  final String link;
  final ActionType action;

  ItemModel({
    required this.imageUrl,
    this.title,
    this.text,
    required this.link,
    required this.action,
  });

  factory ItemModel.initFromMap({required Map<String, dynamic> data}) {
    final model = ItemModel(
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'],
      text: data['text'],
      link: data['link'] ?? '',
      action: ActionTypeExtension.unwrapped(data['action']),
    );
    return model;
  }

  toJSON() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'text': text,
      'link': link,
      'action': action,
    };
  }

  @override
  String toString() {
    return 'ItemModel(imageUrl: $imageUrl, title: $title, text: $text, link: $link, action: $action)';
  }
}

