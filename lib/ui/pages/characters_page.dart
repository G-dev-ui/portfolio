import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/character_bloc.dart';
import '../../bloc/character_event.dart';
import '../../bloc/character_state.dart';
import '../widgets/character_card.dart';
import 'favorites_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final bloc = context.read<CharacterBloc>();
      bloc.add(LoadMoreCharacters(bloc.state.currentPage + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state.isLoading && state.characters.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text('Ошибка: ${state.errorMessage}'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<CharacterBloc>().add(LoadCharacters());
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.characters.length +
                (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.characters.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final character = state.characters[index];
              final isFav = state.favorites
                  .any((fav) => fav.id == character.id);

              return CharacterCard(
                character: character,
                isFavorite: isFav,
                onToggleFavorite: () {
                  context.read<CharacterBloc>().add(ToggleFavorite(character));
                },
              );
            },
          ),
        );
      },
    );
  }
}
