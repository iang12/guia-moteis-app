import 'suite_model.dart';

class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final List<SuiteModel> suites;
  final int qtdAvaliacoes;
  final double media;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
    required this.qtdAvaliacoes,
    required this.media,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) => MotelModel(
        fantasia: json["fantasia"],
        logo: json["logo"],
        bairro: json["bairro"],
        distancia: json["distancia"]?.toDouble(),
        qtdFavoritos: json["qtdFavoritos"],
        suites: List<SuiteModel>.from(
            json["suites"].map((x) => SuiteModel.fromJson(x))),
        qtdAvaliacoes: json["qtdAvaliacoes"],
        media: json["media"]?.toDouble(),
      );
}
