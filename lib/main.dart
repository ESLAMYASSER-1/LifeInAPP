import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lifeinapp/Screens/Main_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://nbxzsupnobgxoweozwkf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ieHpzdXBub2JneG93ZW96d2tmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4ODM5OTEsImV4cCI6MjA1OTQ1OTk5MX0.U1DGjuKnRSxgExoazQciX74zrbxpprsITowVjV9L8wU',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      title: 'LifeInApp',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      home: Main_Page(),
    );
  }
}
