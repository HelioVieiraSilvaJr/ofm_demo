import 'package:ofm_demo/Resources/DesignSystem/Models/SectionModel.dart';

class ProductModel {
  final String title;
  final String brand;
  final String productId;
  final String price;
  final String? pricePromotional;
  final String? tag;
  final List<SizeModel> sizes;
  final List<SectionModel> sections;
  final List<ProductSKU> productSKU;

  ProductModel({
    required this.title,
    required this.brand,
    required this.productId,
    required this.price,
    this.pricePromotional,
    this.tag,
    required this.sizes,
    required this.sections,
    required this.productSKU,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> sectionList = json['sections'] ?? [];
    List<SectionModel> sections =
        sectionList.map((item) => SectionModel.fromJson(item)).toList();

    List<dynamic> productSKUList = json['productSKU'] ?? [];
    List<ProductSKU> productSKU =
        productSKUList.map((item) => ProductSKU.fromJson(item)).toList();

    return ProductModel(
      title: json['title'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      price: json['price'] as String? ?? '',
      pricePromotional: json['pricePromotional'] as String?,
      tag: json['tag'] as String?,
      sizes: (json['sizes'] as List<Map<String, dynamic>>?)
              ?.map((data) => SizeModel.fromJson(data))
              .toList() ??
          [],
      sections: sections,
      productSKU: productSKU,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'brand': brand,
        'productId': productId,
        'price': price,
        'pricePromotional': pricePromotional,
        'tag': tag,
        'sizes': sizes.map((e) => e.toJson()).toList(),
        'sections': sections.map((e) => e.toJson()).toList(),
        'productSKU': productSKU.map((e) => e.toJson()).toList(),
      };
}

class ProductImage {
  final String id;
  final String url;

  ProductImage({required this.id, required this.url});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json['id'] as String? ?? '',
        url: json['url'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
}

class SizeModel {
  final String size;
  final bool available;
  final String? senseOfUrgency;
  bool selected = false;

  SizeModel({required this.size, required this.available, this.senseOfUrgency});

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        size: json['size'] as String? ?? '',
        available: json['available'] as bool? ?? false,
        senseOfUrgency: json['senseOfUrgency'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'size': size,
        'available': available,
        'senseOfUrgency': senseOfUrgency,
      };
}

class ProductSKU {
  final String sku;
  final String? name;
  final String? thumbSKU;
  final List<SKUImage> images;
  final List<SizeModel> sizes;

  ProductSKU({
    required this.sku,
    this.name,
    this.thumbSKU,
    required this.images,
    required this.sizes,
  });

  factory ProductSKU.fromJson(Map<String, dynamic> json) {
    return ProductSKU(
      sku: json['sku'] as String? ?? '',
      name: json['name'] as String?,
      thumbSKU: json['thumbSKU'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => SKUImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'sku': sku,
        if (name != null) 'name': name,
        if (thumbSKU != null) 'skuImage': thumbSKU,
        'images': images.map((e) => e.toJson()).toList(),
        'sizes': sizes.map((e) => e.toJson()).toList(),
      };
}

class SKUImage {
  final String type;
  final String url;

  SKUImage({required this.type, required this.url});

  factory SKUImage.fromJson(Map<String, dynamic> json) => SKUImage(
        type: json['type'] as String? ?? '',
        url: json['url'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
      };
}
