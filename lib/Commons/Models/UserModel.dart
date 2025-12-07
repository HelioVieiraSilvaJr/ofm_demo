class UserModel {
  String uid;
  String name;
  List<String> permissions;
  String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.permissions,
    required this.email,
  });

  // Construtor factory para criar uma instância a partir de JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((permission) => permission as String)
              .toList() ??
          [],
      email: json['email'] as String? ?? '',
    );
  }

  // Método para converter a instância para JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'permissions': permissions,
      'email': email,
    };
  }

  // Método copyWith para criar uma nova instância com alguns valores alterados
  UserModel copyWith({
    String? uid,
    String? name,
    List<String>? permissions,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, permissions: $permissions, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        _listEquals(other.permissions, permissions) &&
        other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ permissions.hashCode ^ email.hashCode;
  }

  // Método auxiliar para comparar listas
  bool _listEquals(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  // Métodos utilitários para verificar permissões
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  bool hasAnyPermission(List<String> permissionList) {
    return permissionList.any((permission) => permissions.contains(permission));
  }

  bool hasAllPermissions(List<String> permissionList) {
    return permissionList
        .every((permission) => permissions.contains(permission));
  }
}
