// lib/main.dart

import 'package:flutter/material.dart';
import 'package:train_reservation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매 앱',
      // 1. 시스템 설정(라이트/다크)을 따르도록 설정
      themeMode: ThemeMode.system,

      // 2. 라이트 모드 테마
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[200], // 화면 전체 배경
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        // 카드, 컨테이너 등의 기본 배경색
        cardColor: Colors.white,
      ),

      // 3. 다크 모드 테마
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFF121212), // 어두운 화면 전체 배경
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.grey[900], // 어두운 카드, 컨테이너 배경색
      ),
      home: const HomePage(),
    );
  }
}
