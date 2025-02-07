import 'package:flutter/material.dart';

import '../../domain/models/suite_model.dart';
import 'suite_card_widget.dart';

class SuiteListWidget extends StatefulWidget {
  final List<SuiteModel> suites;
  const SuiteListWidget({super.key, required this.suites});

  @override
  State<SuiteListWidget> createState() => _SuiteListWidgetState();
}

class _SuiteListWidgetState extends State<SuiteListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.suites.length,
        itemBuilder: (_, index) {
          var suite = widget.suites[index];
          return SuiteCardWidget(suite: suite);
        },
      ),
    );
  }
}
