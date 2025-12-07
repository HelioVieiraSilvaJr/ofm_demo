class CompanyModel {
  String uid;
  String corporativeName;
  String fantasyName;
  String identifier;
  String email;
  List<Map<String, dynamic>> users;
  Map<String, dynamic>? metadata;

  CompanyModel({
    required this.uid,
    required this.corporativeName,
    required this.fantasyName,
    required this.identifier,
    required this.email,
    required this.users,
    this.metadata,
  });

  // Construtor factory para criar uma instância a partir de JSON
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      uid: json['uid'] as String? ?? '',
      corporativeName: json['corporativeName'] as String? ?? '',
      fantasyName: json['fantasyName'] as String? ?? '',
      identifier: json['identifier'] as String? ?? '',
      email: json['email'] as String? ?? '',
      users: (json['users'] as List<dynamic>?)
              ?.map((user) => user as Map<String, dynamic>)
              .toList() ??
          [],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  // Método para converter a instância para JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'corporativeName': corporativeName,
      'fantasyName': fantasyName,
      'identifier': identifier,
      'email': email,
      'users': users,
      'metadata': metadata,
    };
  }

  // Método copyWith para criar uma nova instância com alguns valores alterados
  CompanyModel copyWith({
    String? uid,
    String? corporativeName,
    String? fantasyName,
    String? identifier,
    String? email,
    List<Map<String, dynamic>>? users,
    Map<String, dynamic>? metadata,
  }) {
    return CompanyModel(
      uid: uid ?? this.uid,
      corporativeName: corporativeName ?? this.corporativeName,
      fantasyName: fantasyName ?? this.fantasyName,
      identifier: identifier ?? this.identifier,
      email: email ?? this.email,
      users: users ?? this.users,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return 'CompanyModel(uid: $uid, corporativeName: $corporativeName, fantasyName: $fantasyName, identifier: $identifier, email: $email, users: $users, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CompanyModel &&
        other.uid == uid &&
        other.corporativeName == corporativeName &&
        other.fantasyName == fantasyName &&
        other.identifier == identifier &&
        other.email == email &&
        _listEquals(other.users, users) &&
        _mapEquals(other.metadata ?? {}, metadata ?? {});
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        corporativeName.hashCode ^
        fantasyName.hashCode ^
        identifier.hashCode ^
        email.hashCode ^
        users.hashCode ^
        metadata.hashCode;
  }

  // Método auxiliar para comparar listas
  bool _listEquals(
      List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (!_mapEquals(list1[i], list2[i])) return false;
    }
    return true;
  }

  /// Método auxiliar para comparar mapas
  bool _mapEquals(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) return false;
    }
    return true;
  }

  // Métodos utilitários para acessar metadata
  String? get urlLogo => metadata?['urlLogo'] as String?;
  String? get urlBackground => metadata?['urlBackground'] as String?;

  // Métodos para atualizar URLs específicas
  CompanyModel updateUrlLogo(String url) {
    final updatedMetadata = Map<String, dynamic>.from(metadata ?? {});
    updatedMetadata['urlLogo'] = url;
    return copyWith(metadata: updatedMetadata);
  }

  CompanyModel updateUrlBackground(String url) {
    final updatedMetadata = Map<String, dynamic>.from(metadata ?? {});
    updatedMetadata['urlBackground'] = url;
    return copyWith(metadata: updatedMetadata);
  }
}
