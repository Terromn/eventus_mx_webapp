import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingScreen({Key? key, this.color = Colors.blue, this.size = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
