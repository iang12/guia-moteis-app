class PeriodoModel {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final double? desconto;

  PeriodoModel({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    required this.desconto,
  });

  factory PeriodoModel.fromJson(Map<String, dynamic> json) => PeriodoModel(
        tempoFormatado: json["tempoFormatado"],
        tempo: json["tempo"],
        valor: json["valor"]?.toDouble(),
        valorTotal: json["valorTotal"]?.toDouble(),
        temCortesia: json["temCortesia"],
        desconto: json["desconto"] == null
            ? null
            : json["desconto"]["desconto"]?.toDouble(),
      );
}
