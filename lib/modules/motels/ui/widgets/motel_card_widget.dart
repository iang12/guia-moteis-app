import 'package:flutter/material.dart';

import '../../domain/models/motel_model.dart';
import 'suite_list_widget.dart';

class MotelCardWidget extends StatefulWidget {
  final MotelModel motel;
  const MotelCardWidget({super.key, required this.motel});

  @override
  State<MotelCardWidget> createState() => _MotelCardWidgetState();
}

class _MotelCardWidgetState extends State<MotelCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.motel.logo),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.motel.fantasia,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    widget.motel.bairro,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.orange),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(widget.motel.media.toString())
                          ],
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                          '${widget.motel.qtdAvaliacoes.toString()} avaliações'),
                      SizedBox(height: 16),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          SuiteListWidget(suites: widget.motel.suites),
        ],
      ),
    );
  }
}
