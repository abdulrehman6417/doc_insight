import 'package:doc_insight/firebase_options.dart';
import 'package:doc_insight/models/profile_controller.dart';
import 'package:doc_insight/providers/chat_provider.dart';
import 'package:doc_insight/providers/models_provider.dart';
import 'package:doc_insight/screens/splash_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor myColor = const MaterialColor(
    0xFF0A0E21,
    <int, Color>{
      50: Color(0xFF0A0E21),
      100: Color(0xFF0A0E21),
      200: Color(0xFF0A0E21),
      300: Color(0xFF0A0E21),
      400: Color(0xFF0A0E21),
      500: Color(0xFF0A0E21),
      600: Color(0xFF0A0E21),
      700: Color(0xFF0A0E21),
      800: Color(0xFF0A0E21),
      900: Color(0xFF0A0E21),
    },
  );
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        title: 'DocInsight',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(
              color: primaryBlue,
              width: 2.0,
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
