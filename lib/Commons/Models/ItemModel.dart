class ItemModel {
  final String image;
  final String? title;
  final String? text;
  final String deeplink;

  ItemModel({
    required this.image,
    this.title,
    this.text,
    required this.deeplink,
  });

  factory ItemModel.initFromMap({required Map<String, dynamic> data}) {
    final model = ItemModel(
      image: data['image'] ?? '',
      title: data['title'],
      text: data['text'],
      deeplink: data['deeplink'] ?? '',
    );
    return model;
  }

  toJSON() {
    return {
      'image': image,
      'title': title,
      'text': text,
      'deeplink': deeplink,
    };
  }

  @override
  String toString() {
    return 'ItemModel(image: $image, title: $title, text: $text, deeplink: $deeplink)';
  }
}
