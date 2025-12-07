class ItemModel {
  final String imageUrl;
  final String? title;
  final String? text;
  final String deeplink;

  ItemModel({
    required this.imageUrl,
    this.title,
    this.text,
    required this.deeplink,
  });

  factory ItemModel.initFromMap({required Map<String, dynamic> data}) {
    final model = ItemModel(
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'],
      text: data['text'],
      deeplink: data['deeplink'] ?? '',
    );
    return model;
  }

  toJSON() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'text': text,
      'deeplink': deeplink,
    };
  }

  @override
  String toString() {
    return 'ItemModel(imageUrl: $imageUrl, title: $title, text: $text, deeplink: $deeplink)';
  }
}
