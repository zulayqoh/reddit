import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelProvider);
    return  Scaffold(
      appBar: AppBar(title: const Text('HOME SCREEN'),),
      body: Center(
        child: Text("Name: ${user?.karma}"),
      ),
    );
  }
}