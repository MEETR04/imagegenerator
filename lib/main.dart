import 'package:flutter/material.dart';
import 'package:imagegenerator/feature/prompt/ui/prompt_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900
      ),
      home: PromptScreen(),
    );
  }
}