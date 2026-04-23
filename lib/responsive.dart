import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log("width..${constraints.maxWidth}...${constraints.maxHeight}");

        return Center(child: Text('data'));
      },
    );
  }
}
