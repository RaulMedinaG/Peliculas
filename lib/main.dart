import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'pages/pages.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>MoviesProvider(),
          lazy: false,),
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Pelis',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'detalle': (_) => DetailScreen(),
        'actordetalle': (_) => DetailActorScreen(),
      },
      theme: ThemeData.dark(useMaterial3: true)
      .copyWith(appBarTheme: AppBarTheme(color: Colors.amber[300])),
    );
  }
}
