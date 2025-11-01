import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_event.dart';
import 'character_state.dart';
import '../data/repository/character_repository.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc(this.repository) : super(const CharacterState()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadFavorites>(_onLoadFavorites);
  }

  Future<void> _onLoadCharacters(
      LoadCharacters event, Emitter<CharacterState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final characters = await repository.getCharacters(event.page);
      final favorites = repository.getFavorites();
      emit(state.copyWith(
        characters: characters,
        favorites: favorites,
        isLoading: false,
        currentPage: event.page,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadMoreCharacters(
      LoadMoreCharacters event, Emitter<CharacterState> emit) async {
    if (state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final newCharacters = await repository.getCharacters(event.nextPage);
      emit(state.copyWith(
        characters: [...state.characters, ...newCharacters],
        isLoadingMore: false,
        currentPage: event.nextPage,
      ));
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<CharacterState> emit) async {
    await repository.toggleFavorite(event.character);
    final updatedFavorites = repository.getFavorites();
    emit(state.copyWith(favorites: updatedFavorites));
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<CharacterState> emit) async {
    final favorites = repository.getFavorites();
    emit(state.copyWith(favorites: favorites));
  }
}
