import 'package:flutter/material.dart';

Future<void> commanLoder(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void backScreen(BuildContext context) {
  return Navigator.of(context).pop();
}
