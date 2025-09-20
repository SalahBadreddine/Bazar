import 'package:bazar/providers/user_provider.dart';
import 'package:bazar/views/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://kooracbyypdjpqgavaol.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvb3JhY2J5eXBkanBxZ2F2YW9sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzNzEzNzMsImV4cCI6MjA3Mzk0NzM3M30.MBh3JrVoFEw03YP8XabPSBuOCebiQGSSyveEb7dr58M",
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bazar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: "Futura",
      ),
      home: const WidgetTree(),
    );
  }
}