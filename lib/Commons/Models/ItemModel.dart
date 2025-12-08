import 'package:ofm_demo/Commons/Enums/ActionType.dart';

class ItemModel {
  final String imageUrl;
  final String? title;
  final String? text;
  final String? link;
  final ActionType action;
  final String? tag;
  final String? price;
  final String? pricePromotional;

  ItemModel({
    required this.imageUrl,
    this.title,
    this.text,
    this.link,
    required this.action,
    this.tag,
    this.price,
    this.pricePromotional,
  });

  factory ItemModel.fromJson(Map<String, dynamic> data) {
    final model = ItemModel(
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'],
      text: data['text'],
      link: data['link'] ?? '',
      action: ActionTypeExtension.unwrapped(data['action']),
      tag: data['tag'],
      price: data['price'],
      pricePromotional: data['pricePromotional'],
    );
    return model;
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'text': text,
      'link': link,
      'action': action,
      'tag': tag,
      'price': price,
      'pricePromotional': pricePromotional,
    };
  }

  @override
  String toString() {
    return 'ItemModel(imageUrl: $imageUrl, title: $title, text: $text, link: $link, action: $action, tag: $tag, price: $price, pricePromotional: $pricePromotional)';
  }
}
