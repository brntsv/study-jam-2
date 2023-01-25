import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/view/auth_screen.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xFFEFF0E8),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color(0xFF006e17),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(
        authRepository: AuthRepository(StudyJamClient()),
      ),
    );
  }
}
