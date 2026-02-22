import 'package:flutter/material.dart';
import 'screens/inspection_screen.dart';

void main() {
  runApp(const PLCInspectionApp());
}

class PLCInspectionApp extends StatelessWidget {
  const PLCInspectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLC Inspection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const InspectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}