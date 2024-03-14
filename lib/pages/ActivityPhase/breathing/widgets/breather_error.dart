import 'package:flutter/material.dart';

class BreatheError extends StatelessWidget {
  const BreatheError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: null,
            child: Text("please select valid choice"),
          ),
        ],
      ),
    );
  }
}
