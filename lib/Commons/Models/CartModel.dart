import 'package:ofm_demo/Commons/Models/SectionModel.dart';

class CartModel {
  final List<CartProduct> products;
  final BillingSummary billingSummary;
  final List<SectionModel> sections;

  CartModel({
    required this.products,
    required this.billingSummary,
    required this.sections,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      products: (json['products'] as List<dynamic>?)
              ?.map(
                  (item) => CartProduct.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      billingSummary: BillingSummary.fromJson(
          json['billingSummary'] as Map<String, dynamic>),
      sections: (json['sections'] as List<dynamic>?)
              ?.map(
                  (item) => SectionModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((item) => item.toJson()).toList(),
      'billingSummary': billingSummary.toJson(),
      'sections': sections.map((item) => item.toJson()).toList(),
    };
  }
}

class CartProduct {
  final String sku;
  final String productId;
  final String name;
  final String thumbSKU;
  final String size;
  final String? tag;
  final String price;
  final String? pricePromotional;

  CartProduct({
    required this.sku,
    required this.productId,
    required this.name,
    required this.thumbSKU,
    required this.size,
    this.tag,
    required this.price,
    this.pricePromotional,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      sku: json['sku'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      thumbSKU: json['thumbSKU'] as String? ?? '',
      size: json['size'] as String? ?? '',
      tag: json['tag'] as String?,
      price: json['price'] as String? ?? '',
      pricePromotional: json['pricePromotional'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'productId': productId,
      'name': name,
      'thumbSKU': thumbSKU,
      'size': size,
      'tag': tag,
      'price': price,
      'pricePromotional': pricePromotional,
    };
  }
}

class BillingSummary {
  final String subtotal;
  final String discounts;
  final String shipping;
  final String total;

  BillingSummary({
    required this.subtotal,
    required this.discounts,
    required this.shipping,
    required this.total,
  });

  factory BillingSummary.fromJson(Map<String, dynamic> json) {
    return BillingSummary(
      subtotal: json['subtotal'] as String? ?? '0,00',
      discounts: json['discounts'] as String? ?? '0,00',
      shipping: json['shipping'] as String? ?? '0,00',
      total: json['total'] as String? ?? '0,00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'discounts': discounts,
      'shipping': shipping,
      'total': total,
    };
  }
}
