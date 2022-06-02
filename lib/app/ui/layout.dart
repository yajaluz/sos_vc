import 'package:flutter/material.dart';

class Layout {
  static Widget render({
    required Widget content,
    Widget? fab,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: content,
      ),
      floatingActionButton: fab,
    );
  }

  static Color light([double opacity = 1]) =>
      Color.fromRGBO(230, 230, 230, opacity);
  static Color dark([double opacity = 1]) =>
      Color(0xff333333).withOpacity(opacity);
}
