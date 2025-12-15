class DeliveryModel {
  final List<DeliveryOption> options;

  DeliveryModel({required this.options});

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => DeliveryOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class DeliveryOption {
  final String uid;
  final String type;
  final String name;
  final String? value;
  final String? address;
  final String? recipient;
  final bool isPrincipal;
  final String? bandUrl;
  final String? description;
  final List<Store>? stores;

  DeliveryOption({
    required this.uid,
    required this.type,
    required this.name,
    this.value,
    this.address,
    this.recipient,
    required this.isPrincipal,
    this.bandUrl,
    this.description,
    this.stores,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) {
    return DeliveryOption(
      uid: json['uid'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      value: json['value'],
      address: json['address'],
      recipient: json['recipient'],
      isPrincipal: json['isPrincipal'] ?? false,
      bandUrl: json['bandUrl'],
      description: json['description'],
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Store {
  final String name;
  final String address;
  final String buttonLabel;

  Store({
    required this.name,
    required this.address,
    required this.buttonLabel,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      buttonLabel: json['buttonLabel'] ?? '',
    );
  }
}
