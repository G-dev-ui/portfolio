import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/character_bloc.dart';
import '../../bloc/character_event.dart';
import '../../bloc/character_state.dart';
import '../widgets/character_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String sortType = 'name';

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => sortType = value),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'name', child: Text('По имени')),
              PopupMenuItem(value: 'status', child: Text('По статусу')),
            ],
          )
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          var favorites = [...state.favorites];

          if (sortType == 'name') {
            favorites.sort((a, b) => a.name.compareTo(b.name));
          } else if (sortType == 'status') {
            favorites.sort((a, b) => a.status.compareTo(b.status));
          }

          if (favorites.isEmpty) {
            return const Center(child: Text('Нет избранных персонажей'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final character = favorites[index];
              return CharacterCard(
                character: character,
                isFavorite: true,
                onToggleFavorite: () {
                  context.read<CharacterBloc>().add(ToggleFavorite(character));
                },
              );
            },
          );
        },
      ),
    );
  }
}
