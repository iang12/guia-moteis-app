import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/suite_model.dart';

class SuiteCardWidget extends StatefulWidget {
  const SuiteCardWidget({
    super.key,
    required this.suite,
  });

  final SuiteModel suite;

  @override
  State<SuiteCardWidget> createState() => _SuiteCardWidgetState();
}

class _SuiteCardWidgetState extends State<SuiteCardWidget> {
  final money = NumberFormat("#,##0.00", "pt_BR");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 25,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(widget.suite.fotos[0]),
                    ),
                    Text(
                      widget.suite.nome,
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2),
          Card(
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 90,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.suite.categoriaItens.length,
                itemBuilder: (_, index) {
                  var itens = widget.suite.categoriaItens[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.network(
                        itens.icone,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 2),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.suite.periodos.length,
            itemBuilder: (_, index) {
              var periodo = widget.suite.periodos[index];
              return Card(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        periodo.tempoFormatado,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'R\$ ${money.format(periodo.valorTotal)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
