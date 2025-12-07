class ItemModel {
  final String imageUrl;
  final String? title;
  final String? text;
  final String link;

  ItemModel({
    required this.imageUrl,
    this.title,
    this.text,
    required this.link,
  });

  factory ItemModel.initFromMap({required Map<String, dynamic> data}) {
    final model = ItemModel(
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'],
      text: data['text'],
      link: data['link'] ?? '',
    );
    return model;
  }

  toJSON() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'text': text,
      'link': link,
    };
  }

  @override
  String toString() {
    return 'ItemModel(imageUrl: $imageUrl, title: $title, text: $text, link: $link)';
  }
}
