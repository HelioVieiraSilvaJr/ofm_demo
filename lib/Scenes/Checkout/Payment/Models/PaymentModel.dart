class PaymentModel {
  final List<Coupon> coupons;
  final List<PaymentOption> options;

  PaymentModel({required this.coupons, required this.options});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      coupons: (json['coupons'] as List<dynamic>?)
              ?.map((e) => Coupon.fromJson(e))
              .toList() ??
          [],
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => PaymentOption.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'coupons': coupons.map((e) => e.toJson()).toList(),
        'options': options.map((e) => e.toJson()).toList(),
      };
}

class Coupon {
  final String uid;
  final String type;
  final String name;
  final String description;

  Coupon({
    required this.uid,
    required this.type,
    required this.name,
    required this.description,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      uid: json['uid'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'type': type,
        'name': name,
        'description': description,
      };
}

class PaymentOption {
  final String uid;
  final String type;
  final String name;
  final List<String> bands;

  PaymentOption({
    required this.uid,
    required this.type,
    required this.name,
    required this.bands,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      uid: json['uid'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      bands: (json['bands'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'type': type,
        'name': name,
        'bands': bands,
      };
}
