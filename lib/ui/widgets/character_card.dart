import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../../data/models/character_model.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.isFavorite,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Widget _buildLoader() {
    return RotationTransition(
      turns: _rotationController,
      child: Image.asset(
        'assets/images/refresh.png',
        height: 28,
        width: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: character.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: _buildLoader()),
            errorWidget: (context, url, error) => const Icon(
              Icons.broken_image,
              size: 24,
              color: Colors.grey,
            ),
          ),
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${character.species} — ${character.status}'),
        trailing: SizedBox(
          width: 35,
          height: 35,
          child: LikeButton(
            isLiked: widget.isFavorite,
            onTap: (bool isLiked) async {
              widget.onToggleFavorite();
              return !isLiked;
            },
          ),
        ),
      ),
    );
  }
}
