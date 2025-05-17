import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
              Scaffold(
                appBar: AppBar(title: const Text('No Route Found')),
                body: const Center(child: Text('No Route Found')),
              ),
        );
    }
  }
}