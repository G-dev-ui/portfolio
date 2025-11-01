import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'data/services/local_storage.dart';
import 'data/services/api_service.dart';
import 'data/repository/character_repository.dart';
import 'bloc/character_bloc.dart';
import 'bloc/character_event.dart';       // <- для LoadCharacters
import 'ui/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final storage = LocalStorage();
  await storage.init();

  final repository = CharacterRepository(
    api: ApiService(),
    local: storage,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CharacterRepository repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterBloc(repository)..add(LoadCharacters()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainNavigation(),
      ),
    );
  }
}
