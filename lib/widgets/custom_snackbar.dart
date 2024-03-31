import 'package:flutter/material.dart';

enum MessageType { success, error, warning }

SnackBar customSnackBar(
    {required String content, MessageType? type = MessageType.success}) {
  return SnackBar(
    backgroundColor: type == MessageType.success
        ? Colors.green
        : type == MessageType.warning
            ? Colors.orange
            : Colors.red,
    content: Text(content),
  );
}
