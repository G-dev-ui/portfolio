import '../models/character_model.dart';
import '../services/api_service.dart';
import '../services/local_storage.dart';

class CharacterRepository {
  final ApiService api;
  final LocalStorage local;

  CharacterRepository({required this.api, required this.local});

  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      // Загружаем страницу с API
      final characters = await api.fetchCharacters(page);
      // Кешируем именно эту страницу
      await local.cacheCharacters(characters, page);
      return characters;
    } catch (_) {
      // Если интернет недоступен — берем кеш только для нужной страницы
      final cached = local.getCachedCharacters(page: page);
      if (cached.isNotEmpty) {
        return cached;
      }
      // Если кеш пустой — возвращаем пустой список
      return [];
    }
  }

  Future<void> toggleFavorite(CharacterModel character) async {
    await local.toggleFavorite(character);
  }

  List<CharacterModel> getFavorites() {
    return local.getFavorites();
  }
}
