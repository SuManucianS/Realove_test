import 'package:flutter/material.dart';
import 'package:real_love/style/colors.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}