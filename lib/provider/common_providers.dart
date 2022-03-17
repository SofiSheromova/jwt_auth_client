import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CommonProviders extends StatelessWidget {
  final Widget child;

  const CommonProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Logger>(
          create: (context) => Logger(
            printer: PrettyPrinter(
              methodCount: 2,
              errorMethodCount: 8,
              lineLength: 120,
              printTime: true,
              colors: false,
              printEmojis: false,
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
