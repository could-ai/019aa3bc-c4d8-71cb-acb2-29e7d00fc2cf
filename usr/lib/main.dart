import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';

void main() {
  runApp(const CarmomixApp());
}

class CarmomixApp extends StatelessWidget {
  const CarmomixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carmomix Official',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE50914), // Un rojo intenso estilo Netflix/YouTube Music
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), // Casi negro
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFFFFA726), // Naranja dorado para acentos
          surface: Color(0xFF1E1E1E),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -1.0),
          displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18, height: 1.5, color: Colors.white70),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
