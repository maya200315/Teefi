import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teefi/providers/behavior_provider.dart';
import 'package:teefi/providers/parent_pecs_provider.dart';
import 'package:teefi/views/splash/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/parents_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/parent_details_provider.dart';
import 'providers/content_provider.dart';
import 'providers/pecs_provider.dart';
import 'providers/specialists_provider.dart';
import 'providers/parent_home_provider.dart';
import 'package:teefi/views/parent/record_behavior_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ParentsProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ParentDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => PecsProvider()),
        ChangeNotifierProvider(create: (_) => SpecialistsProvider()),
        ChangeNotifierProvider(create: (_) => ParentHomeProvider()),
        ChangeNotifierProvider(create: (_) => ParentPecsProvider()),
        ChangeNotifierProvider(create: (_) => BehaviorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}