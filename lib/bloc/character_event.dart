import 'package:equatable/equatable.dart';
import '../data/models/character_model.dart';

abstract class CharacterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharacterEvent {
  final int page;
  LoadCharacters({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadMoreCharacters extends CharacterEvent {
  final int nextPage;
  LoadMoreCharacters(this.nextPage);

  @override
  List<Object?> get props => [nextPage];
}

class ToggleFavorite extends CharacterEvent {
  final CharacterModel character;
  ToggleFavorite(this.character);

  @override
  List<Object?> get props => [character];
}

class LoadFavorites extends CharacterEvent {}
