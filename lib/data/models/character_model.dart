class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String location;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.location,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    String locationName;

    if (json['location'] is String) {
      locationName = json['location'];
    } else if (json['location'] is Map && json['location']['name'] != null) {
      locationName = json['location']['name'];
    } else {
      locationName = '';
    }

    return CharacterModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      image: json['image'] ?? '',
      location: locationName,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'image': image,
    'location': location,
  };
}
