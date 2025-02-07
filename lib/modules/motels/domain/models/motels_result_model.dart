import 'motel_model.dart';

class MotelsResultModel {
  final int pagina;
  final int qtdPorPagina;
  final int totalSuites;
  final int totalMoteis;
  final int raio;
  final int maxPaginas;
  final List<MotelModel> moteis;

  MotelsResultModel({
    required this.pagina,
    required this.qtdPorPagina,
    required this.totalSuites,
    required this.totalMoteis,
    required this.raio,
    required this.maxPaginas,
    required this.moteis,
  });

  factory MotelsResultModel.fromJson(Map<String, dynamic> json) =>
      MotelsResultModel(
        pagina: json["pagina"],
        qtdPorPagina: json["qtdPorPagina"],
        totalSuites: json["totalSuites"],
        totalMoteis: json["totalMoteis"],
        raio: json["raio"],
        maxPaginas: json["maxPaginas"].toInt(),
        moteis: List<MotelModel>.from(
            json["moteis"].map((x) => MotelModel.fromJson(x))),
      );
}
