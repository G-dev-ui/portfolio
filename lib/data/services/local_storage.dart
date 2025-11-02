import 'package:hive/hive.dart';
import '../models/character_model.dart';

class LocalStorage {
  static const String favoritesBoxName = 'favorites_box';
  static const String cacheBoxName = 'characters_cache';

  Future<void> init() async {
    await Hive.openBox(favoritesBoxName);
    await Hive.openBox(cacheBoxName);
  }

  // Сохраняем страницу отдельно
  Future<void> cacheCharacters(List<CharacterModel> characters, int page) async {
    final box = Hive.box(cacheBoxName);
    await box.put('characters_page_$page', characters.map((c) => c.toJson()).toList());
  }

  // Читаем конкретную страницу
  List<CharacterModel> getCachedCharacters({int page = 1}) {
    final box = Hive.box(cacheBoxName);
    final data = box.get('characters_page_$page', defaultValue: []);
    return (data as List)
        .map((json) => CharacterModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> toggleFavorite(CharacterModel character) async {
    final box = Hive.box(favoritesBoxName);
    final key = character.id.toString();
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, character.toJson());
    }
  }

  List<CharacterModel> getFavorites() {
    final box = Hive.box(favoritesBoxName);
    return box.values
        .map((e) => CharacterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
