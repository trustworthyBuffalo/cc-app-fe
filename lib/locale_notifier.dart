import 'package:flutter/material.dart';

class LocaleNotifier {
  static final ValueNotifier<Locale> locale =
      ValueNotifier(const Locale('id'));

  static void setLocale(Locale newLocale) {
    locale.value = newLocale;
  }
}
