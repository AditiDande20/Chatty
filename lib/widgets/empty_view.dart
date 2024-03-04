import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class EmptyView extends StatelessWidget {
  final String message;
  const EmptyView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message,
          style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: CustomColors.baseColor)),
    );
  }
}
