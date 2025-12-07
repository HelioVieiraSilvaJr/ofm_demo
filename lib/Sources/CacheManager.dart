/// Gerenciador de cache em memória para armazenar dados durante a execução da aplicação.
///
/// Permite armazenar e recuperar valores de qualquer tipo usando um sistema de chave-valor.
class CacheManager {
  CacheManager._();

  static final CacheManager _instance = CacheManager._();

  /// Retorna a instância singleton do CacheManager
  static CacheManager get instance => _instance;

  /// Mapa interno para armazenar os dados em cache
  final Map<String, dynamic> _cache = {};

  /// Armazena um valor no cache com a chave especificada.
  ///
  /// [key] - A chave única para identificar o valor
  /// [value] - O valor a ser armazenado (pode ser String, Object, List, etc.)
  ///
  /// Exemplo:
  /// ```dart
  /// CacheManager.instance.set('user_name', 'João');
  /// CacheManager.instance.set('user_data', {'id': 1, 'name': 'João'});
  /// CacheManager.instance.set('items', [1, 2, 3]);
  /// ```
  void set(String key, dynamic value) {
    _cache[key] = value;
  }

  /// Recupera um valor do cache pela chave especificada.
  ///
  /// [key] - A chave do valor a ser recuperado
  ///
  /// Retorna o valor convertido para o tipo genérico T, ou null se a chave não existir.
  ///
  /// Exemplo:
  /// ```dart
  /// String? name = CacheManager.instance.get<String>('user_name');
  /// Map<String, dynamic>? userData = CacheManager.instance.get<Map<String, dynamic>>('user_data');
  /// List<int>? items = CacheManager.instance.get<List<int>>('items');
  /// ```
  T? get<T>(String key) {
    final value = _cache[key];
    if (value == null) return null;

    try {
      return value as T;
    } catch (e) {
      return null;
    }
  }

  /// Verifica se existe um valor para a chave especificada.
  ///
  /// [key] - A chave a ser verificada
  ///
  /// Retorna true se a chave existe, false caso contrário.
  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  /// Remove um valor do cache pela chave especificada.
  ///
  /// [key] - A chave do valor a ser removido
  ///
  /// Retorna o valor removido, ou null se a chave não existir.
  dynamic remove(String key) {
    return _cache.remove(key);
  }

  /// Limpa todo o cache, removendo todos os valores armazenados.
  void clear() {
    _cache.clear();
  }

  /// Retorna todas as chaves armazenadas no cache.
  Iterable<String> get keys => _cache.keys;

  /// Retorna o número de itens armazenados no cache.
  int get length => _cache.length;

  /// Retorna true se o cache estiver vazio.
  bool get isEmpty => _cache.isEmpty;

  /// Retorna true se o cache não estiver vazio.
  bool get isNotEmpty => _cache.isNotEmpty;
}
