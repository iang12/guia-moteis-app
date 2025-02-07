import 'periodo_model.dart';

class SuiteModel {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<String> itens;
  final List<CategoriaItenSuite> categoriaItens;
  final List<PeriodoModel> periodos;

  SuiteModel({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) => SuiteModel(
        nome: json["nome"],
        qtd: json["qtd"],
        exibirQtdDisponiveis: json["exibirQtdDisponiveis"],
        fotos: List<String>.from(json["fotos"].map((x) => x)),
        itens: List<String>.from(json["itens"].map((x) => x["nome"])),
        categoriaItens: List<CategoriaItenSuite>.from(
            json["categoriaItens"].map((x) => CategoriaItenSuite.fromJson(x))),
        periodos: List<PeriodoModel>.from(
            json["periodos"].map((x) => PeriodoModel.fromJson(x))),
      );
}

class CategoriaItenSuite {
  String nome;
  String icone;

  CategoriaItenSuite({
    required this.nome,
    required this.icone,
  });

  factory CategoriaItenSuite.fromJson(Map<String, dynamic> json) =>
      CategoriaItenSuite(
        nome: json["nome"],
        icone: json["icone"],
      );
}
