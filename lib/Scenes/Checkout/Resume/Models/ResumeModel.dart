class ResumeModel {
  final List<ResumeProduct> products;
  final ResumeDelivery delivery;
  final ResumePayment payment;
  final ResumeBilling billing;

  ResumeModel({
    required this.products,
    required this.delivery,
    required this.payment,
    required this.billing,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ResumeProduct.fromJson(e))
              .toList() ??
          [],
      delivery: ResumeDelivery.fromJson(json['delivery'] ?? {}),
      payment: ResumePayment.fromJson(json['payment'] ?? {}),
      billing: ResumeBilling.fromJson(json['billing'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'products': products.map((e) => e.toJson()).toList(),
        'delivery': delivery.toJson(),
        'payment': payment.toJson(),
        'billing': billing.toJson(),
      };
}

class ResumeProduct {
  final String productId;
  final String name;
  final String imageUrl;
  final String productUrl;
  final int quantity;

  ResumeProduct({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.productUrl,
    required this.quantity,
  });

  factory ResumeProduct.fromJson(Map<String, dynamic> json) {
    return ResumeProduct(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      productUrl: json['productUrl'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'imageUrl': imageUrl,
        'productUrl': productUrl,
        'quantity': quantity,
      };
}

class ResumeDelivery {
  final String method;
  final String recipient;
  final String address;

  ResumeDelivery({
    required this.method,
    required this.recipient,
    required this.address,
  });

  factory ResumeDelivery.fromJson(Map<String, dynamic> json) {
    return ResumeDelivery(
      method: json['method'] ?? '',
      recipient: json['recipient'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'method': method,
        'recipient': recipient,
        'address': address,
      };
}

class ResumePayment {
  final String method;
  final String name;

  ResumePayment({
    required this.method,
    required this.name,
  });

  factory ResumePayment.fromJson(Map<String, dynamic> json) {
    return ResumePayment(
      method: json['method'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'method': method,
        'name': name,
      };
}

class ResumeBilling {
  final String shipping;
  final String total;

  ResumeBilling({
    required this.shipping,
    required this.total,
  });

  factory ResumeBilling.fromJson(Map<String, dynamic> json) {
    return ResumeBilling(
      shipping: json['shipping'] ?? '',
      total: json['total'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'shipping': shipping,
        'total': total,
      };
}
