import 'package:codebase/shared/widgets/test_font.dart';
import 'package:codebase/shared/widgets/test_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Codebase App', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const TestFont(fontFamily: 'Montserrat')));
              },
              child: const Text('Test Font'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const TestLogger()));
              },
              child: const Text('Test Logger'),
            ),
          ],
        ),
      ),
    );
  }
}
