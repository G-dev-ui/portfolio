import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки персонажей');
    }
  }
}
