import 'package:flutter/material.dart';
import 'package:kaffo/core/widgets/main_scaffold.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: Center(
      child: Text('AppLocalizations.of(context)!.home'),
    ));
  }
}
