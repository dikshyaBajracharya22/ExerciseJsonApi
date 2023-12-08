import 'package:exercise_json/ui/screen/home_screen.dart';
import 'package:exercise_json/wrapper/multibloc_wrapper.dart';
import 'package:exercise_json/wrapper/multirepository_wrapper.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultiRepositoryWrapper(
      child: MultiBlocWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Exercise App",
          home: HomeScreen(),
        
        ),
      ),
    );
  }
}
