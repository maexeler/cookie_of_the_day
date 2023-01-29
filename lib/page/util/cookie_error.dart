import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Display error information and a button to reloaad the cookie
class CookieErrorWidget extends StatelessWidget {
  final String errorMessage;
  final void Function() callback;
  const CookieErrorWidget(this.errorMessage, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          ElevatedButton(
            onPressed: callback,
            child: const Text('Try reload'),
          ),
        ],
      ),
    );
  }
}
