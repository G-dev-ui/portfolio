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
  String sortType = 'name'; // выбранный фильтр
  // ключ = поле модели, value = отображаемое название на русском
  final Map<String, String> filters = {
    'name': 'Имя',
    'status': 'Статус',
    'species': 'Вид',
  };

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // отступы сверху/снизу
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final key = filters.keys.elementAt(index);
                  final label = filters[key]!;
                  final isSelected = sortType == key;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        sortType = key;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white24,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Список персонажей
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                var favorites = [...state.favorites];

                // Сортировка по выбранной характеристике
                favorites.sort((a, b) {
                  switch (sortType) {
                    case 'name':
                      return a.name.compareTo(b.name);
                    case 'status':
                      return a.status.compareTo(b.status);
                    case 'species':
                      return a.species.compareTo(b.species);
                    default:
                      return 0;
                  }
                });

                if (favorites.isEmpty) {
                  return const Center(child: Text('Нет избранных персонажей'));
                }

                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final character = favorites[index];
                    return CharacterCard(
                      key: ValueKey(character.id),
                      character: character,
                      isFavorite: true,
                      onToggleFavorite: () {
                        context
                            .read<CharacterBloc>()
                            .add(ToggleFavorite(character));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
