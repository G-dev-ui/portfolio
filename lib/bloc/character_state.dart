import 'package:equatable/equatable.dart';
import '../data/models/character_model.dart';

class CharacterState extends Equatable {
  final List<CharacterModel> characters;
  final List<CharacterModel> favorites;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final int currentPage;

  const CharacterState({
    this.characters = const [],
    this.favorites = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 1,
  });

  CharacterState copyWith({
    List<CharacterModel>? characters,
    List<CharacterModel>? favorites,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props =>
      [characters, favorites, isLoading, isLoadingMore, errorMessage, currentPage];
}
