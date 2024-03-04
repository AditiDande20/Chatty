import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String message;
  final String description;
  const EmptyScreenWidget(
      {super.key, required this.message, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColors.blackColor,
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
