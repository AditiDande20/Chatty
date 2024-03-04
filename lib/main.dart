import 'package:chatty/providers/chat_provider.dart';
import 'package:chatty/providers/user_list_provider.dart';
import 'package:chatty/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/onboarding/splash.dart';
import 'utils/constants.dart';
import 'utils/custom_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserListProvider()),
    ChangeNotifierProvider(create: (_) => ChatListProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstantsData.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: CustomColors.backgroundColor,
            surfaceTintColor: CustomColors.backgroundColor),
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.baseColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
