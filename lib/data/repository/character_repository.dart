import '../models/character_model.dart';
import '../services/api_service.dart';
import '../services/local_storage.dart';

class CharacterRepository {
  final ApiService api;
  final LocalStorage local;

  CharacterRepository({
    required this.api,
    required this.local,
  });

  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      final characters = await api.fetchCharacters(page);
      await local.cacheCharacters(characters);
      return characters;
    } catch (_) {
      // при оффлайне достаём из кеша
      return local.getCachedCharacters();
    }
  }

  Future<void> toggleFavorite(CharacterModel character) async {
    await local.toggleFavorite(character);
  }

  List<CharacterModel> getFavorites() {
    return local.getFavorites();
  }
}
