import 'package:flutter/material.dart';

import '../../../../../core/widgets/main_scaffold.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyVolunteeringScreen extends StatelessWidget {
  const MyVolunteeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: Center(
      child: Text('AppLocalizations.of(context)!.my_volunteering'),
    ));
  }
}
