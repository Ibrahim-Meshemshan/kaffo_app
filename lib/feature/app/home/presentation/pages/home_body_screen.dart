import 'package:flutter/material.dart';
import 'package:kaffo/core/widgets/main_scaffold.dart';


class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: Center(
      child: Text('Home body screen'),
    ));
  }
}
