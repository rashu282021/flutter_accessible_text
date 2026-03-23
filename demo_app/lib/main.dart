import 'package:flutter/material.dart';
import 'package:flutter_accessible_text/flutter_accessible_text.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Accessible Text Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Accessible Text Demo')),
        body: Builder(
          builder: (context) {
            // Initialize SizeConfig with context
            SizeConfig.init(context);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccessibleText.text(
                    context,
                    'Content Text (Full scaling)',
                    role: TextRole.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  AccessibleText.text(
                    context,
                    'Chrome Text (Capped scaling)',
                    role: TextRole.chrome,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Raw TextScaleFactor: ${SizeConfig.textScale.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: AccessibleText.text(
                      context,
                      'Button Label (Capped)',
                      role: TextRole.chrome,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}