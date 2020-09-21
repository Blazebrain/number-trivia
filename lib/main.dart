import 'package:flutter/material.dart';
import 'package:number_trivial/features/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia App',
      home: NumberTriviaPage(),
      theme: ThemeData(
          primaryColor: Colors.green[800], accentColor: Colors.green[600]),
    );
  }
}
