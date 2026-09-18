import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'features/cashier_shift/screens/pos_login_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ChickenCrunchyRollApp(),
    ),
  );
}

class ChickenCrunchyRollApp extends StatelessWidget {
  const ChickenCrunchyRollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chicken Crunchy Roll POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.surface,
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const PosLoginScreen(),
    );
  }
}
