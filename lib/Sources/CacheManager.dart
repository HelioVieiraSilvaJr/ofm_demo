import 'package:ofm_demo/Sources/Constants.dart';

/// Classe interna para armazenar um valor com seu timestamp de criação
class _CacheEntry {
  final dynamic value;
  final DateTime timestamp;

  _CacheEntry(this.value, this.timestamp);

  /// Verifica se o cache expirou baseado no intervalo especificado
  bool isExpired(int expirationMinutes) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    return difference.inMinutes >= expirationMinutes;
  }
}

/// Gerenciador de cache em memória para armazenar dados durante a execução da aplicação.
///
/// Permite armazenar e recuperar valores de qualquer tipo usando um sistema de chave-valor.
/// O cache expira automaticamente após o intervalo configurado (padrão: 60 minutos).
class CacheManager {
  CacheManager._();

  static final CacheManager _instance = CacheManager._();

  /// Retorna a instância singleton do CacheManager
  static CacheManager get instance => _instance;

  /// Mapa interno para armazenar os dados em cache com timestamp
  final Map<String, _CacheEntry> _cache = {};

  /// Intervalo de expiração do cache em minutos (padrão: 60 minutos)
  int expirationMinutes = 60;

  /// Armazena um valor no cache com a chave especificada.
  ///
  /// [key] - A chave única para identificar o valor
  /// [value] - O valor a ser armazenado (pode ser String, Object, List, etc.)
  ///
  /// O valor será armazenado com um timestamp e expirará após o intervalo configurado em [expirationMinutes].
  ///
  /// Exemplo:
  /// ```dart
  /// CacheManager.instance.set('user_name', 'João');
  /// CacheManager.instance.set('user_data', {'id': 1, 'name': 'João'});
  /// CacheManager.instance.set('items', [1, 2, 3]);
  /// ```
  void set(String key, dynamic value) {
    _cache[key] = _CacheEntry(value, DateTime.now());
  }

  /// Recupera um valor do cache pela chave especificada.
  ///
  /// [key] - A chave do valor a ser recuperado
  ///
  /// Retorna o valor convertido para o tipo genérico T, ou null se a chave não existir
  /// ou se o cache expirou (após o intervalo definido em [expirationMinutes]).
  ///
  /// Exemplo:
  /// ```dart
  /// String? name = CacheManager.instance.get<String>('user_name');
  /// Map<String, dynamic>? userData = CacheManager.instance.get<Map<String, dynamic>>('user_data');
  /// List<int>? items = CacheManager.instance.get<List<int>>('items');
  /// ```
  T? get<T>(String key) {
    if (kCacheEnabled == false) {
      return null;
    }
    final entry = _cache[key];
    if (entry == null) return null;

    // Verifica se o cache expirou
    if (entry.isExpired(expirationMinutes)) {
      _cache.remove(key);
      return null;
    }

    try {
      return entry.value as T;
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

  /// Remove entradas expiradas do cache (valores que ultrapassaram o intervalo de [expirationMinutes]).
  ///
  /// Retorna o número de entradas removidas.
  int clearExpired() {
    final keysToRemove = <String>[];
    for (final entry in _cache.entries) {
      if (entry.value.isExpired(expirationMinutes)) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _cache.remove(key);
    }
    return keysToRemove.length;
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
