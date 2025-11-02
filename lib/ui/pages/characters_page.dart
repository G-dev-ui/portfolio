import 'dart:math' as math;
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/character_bloc.dart';
import '../../bloc/character_event.dart';
import '../../bloc/character_state.dart';
import '../widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final bloc = context.read<CharacterBloc>();
      bloc.add(LoadMoreCharacters(bloc.state.currentPage + 1));
    }
  }

  Widget _buildLoader({double size = 40}) {
    return RotationTransition(
      turns: _rotationController,
      child: Image.asset(
        'assets/images/refresh.png',
        height: size,
        width: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        final characters = state.characters ?? [];
        final favorites = state.favorites ?? [];

        // === Первая загрузка ===
        if (state.isLoading && characters.isEmpty) {
          return Center(child: _buildLoader(size: 60));
        }

        // === Ошибка ===
        if (state.errorMessage != null) {
          return Center(child: Text('Ошибка: ${state.errorMessage}'));
        }

        return Column(
          children: [
            // Верхняя картинка / логотип
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Image.asset(
                'assets/images/Rick_and_Morty_Logo_and_Image.webp',
                fit: BoxFit.contain,
                height: 130,
              ),
            ),

            // Список персонажей
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  context.read<CharacterBloc>().add(LoadCharacters());
                },
                builder: (BuildContext context, Widget child,
                    IndicatorController controller) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      child,
                      if (controller.isLoading || controller.value > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Transform.rotate(
                            angle: controller.value * 2 * math.pi,
                            child: Image.asset(
                              'assets/images/refresh.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                    ],
                  );
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: characters.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    // === Индикатор пагинации ===
                    if (index >= characters.length) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(child: _buildLoader()),
                      );
                    }

                    final character = characters[index];
                    final isFav =
                    favorites.any((fav) => fav.id == character.id);

                    return CharacterCard(
                      character: character,
                      isFavorite: isFav,
                      onToggleFavorite: () {
                        context
                            .read<CharacterBloc>()
                            .add(ToggleFavorite(character));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
