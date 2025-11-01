import 'package:flutter/material.dart';
import '../../data/models/character_model.dart';


class CharacterCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            character.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(character.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${character.species} — ${character.status}'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite ? Colors.amber : Colors.grey,
          ),
          onPressed: onToggleFavorite,
        ),
      ),
    );
  }
}