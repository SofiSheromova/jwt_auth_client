import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;

  const ErrorText(this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          error,
          style: const TextStyle(color: Colors.red),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
