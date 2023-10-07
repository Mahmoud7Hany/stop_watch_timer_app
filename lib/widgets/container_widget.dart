import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, required this.textNumber, required this.textTime});

  final String textNumber;
  final String textTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Text(
            textNumber,
            style: const TextStyle(
              fontSize: 77,
            ),
          ),
        ),
        Text(
          textTime,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ],
    );
  }
}
