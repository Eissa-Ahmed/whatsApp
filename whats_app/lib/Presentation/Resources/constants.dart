import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations language(BuildContext context) {
  return AppLocalizations.of(context)!;
}

Duration duration(int milliseconds) {
  return Duration(milliseconds: milliseconds);
}
