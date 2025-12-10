import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheConfig {
  static const String _cacheKey = 'ofm_demo_cache';
  static late CacheManager _cacheManager;

  static CacheManager get cacheManager => _cacheManager;

  static void setupCache() {
    // Criar o CacheManager customizado
    _cacheManager = CacheManager(
      Config(
        _cacheKey,
        stalePeriod: const Duration(days: 30), // Cache válido por 30 dias
        maxNrOfCacheObjects: 400, // Máximo de 400 objetos em cache
        repo: JsonCacheInfoRepository(databaseName: _cacheKey),
      ),
    );
  }

  static Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }
}
