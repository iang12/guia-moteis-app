import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis_app/core/errors/errors.dart';
import 'package:guia_moteis_app/modules/motels/data/motel_repository.dart';
import 'package:guia_moteis_app/modules/motels/data/motel_repository_impl.dart';
import 'package:guia_moteis_app/modules/motels/domain/errors/motels_failure.dart';

import 'package:guia_moteis_app/modules/motels/domain/models/motels_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClientHttp extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockClientHttp mockClientHttp;
  late MotelRepository repository;

  setUp(() {
    mockClientHttp = MockClientHttp();
    repository = MotelRepositoryImpl(mockClientHttp);
    registerFallbackValue(FakeUri());
  });

  group('getMotels', () {
    test('deve retornar um MotelsResultModel quando a resposta for 200',
        () async {
      when(() => mockClientHttp.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await repository.getMotels();

      expect(result, isA<Right<Failure, MotelsResultModel>>());
    });

    test('deve retornar um erro quando a resposta não for 200', () async {
      when(() => mockClientHttp.get(any()))
          .thenAnswer((_) async => http.Response('Erro', 404));

      final result = await repository.getMotels();

      expect(result.isLeft(), true);
    });

    test('deve retornar um erro quando houver falha de conexão', () async {
      when(() => mockClientHttp.get(any()))
          .thenThrow(http.ClientException('Erro de conexão'));

      final result = await repository.getMotels();

      expect(result, isA<Left<Failure, MotelsResultModel>>());
      result.fold(
        (failure) => expect(failure, isA<GetFailureMotels>()),
        (_) => fail('Deveria ter retornado um erro'),
      );
    });

    test('deve retornar um erro quando a resposta for inválida', () async {
      when(() => mockClientHttp.get(any()))
          .thenAnswer((_) async => http.Response('Resposta inválida', 200));

      final result = await repository.getMotels();

      expect(result, isA<Left<Failure, MotelsResultModel>>());
      result.fold(
        (failure) => expect(failure, isA<GetFailureMotels>()),
        (_) => fail('Deveria ter retornado um erro'),
      );
    });
  });
}

var mockResponse = {
  "data": {
    "raio": 0,
    "moteis": [
      {
        "logo":
            "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
        "media": 4.6,
        "bairro": "Chácara Flora - São Paulo",
        "suites": [
          {
            "qtd": 1,
            "nome": "Suíte Marselha s/ garagem privativa",
            "fotos": [
              "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg",
              "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg",
              "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_3.jpg",
              "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_4.jpg"
            ],
            "itens": [
              {"nome": "ducha dupla"},
              {"nome": "TV a cabo"},
              {"nome": "TV LED 32''"},
              {"nome": "iluminação por leds"},
              {"nome": "garagem coletiva"},
              {"nome": "som AM/FM"},
              {"nome": "3 canais eróticos"},
              {"nome": "bluetooth"},
              {"nome": "espelho no teto"},
              {"nome": "acesso à suíte via escadas"},
              {"nome": "frigobar"},
              {"nome": "ar-condicionado split"},
              {"nome": "WI-FI"},
              {"nome": "secador de cabelo"}
            ],
            "periodos": [
              {
                "tempo": "3",
                "valor": 88,
                "desconto": null,
                "valorTotal": 88,
                "temCortesia": false,
                "tempoFormatado": "3 horas"
              },
              {
                "tempo": "6",
                "valor": 101,
                "desconto": null,
                "valorTotal": 101,
                "temCortesia": false,
                "tempoFormatado": "6 horas"
              },
              {
                "tempo": "12",
                "valor": 129.58,
                "desconto": {"desconto": 48},
                "valorTotal": 81.58,
                "temCortesia": false,
                "tempoFormatado": "12 horas"
              }
            ],
            "categoriaItens": [
              {
                "nome": "Frigobar",
                "icone":
                    "https://cdn.guiademoteis.com.br/Images/itens-suites/frigobar-04-09-2018-12-14.png"
              },
              {
                "nome": "Ar-Condicionado",
                "icone":
                    "https://cdn.guiademoteis.com.br/Images/itens-suites/arcondicionado-04-09-2018-12-13.png"
              },
              {
                "nome": "Internet Wi-Fi",
                "icone":
                    "https://cdn.guiademoteis.com.br/Images/itens-suites/internet-wifi-22-08-2018-11-42.png"
              },
              {
                "nome": "Secador de Cabelo",
                "icone":
                    "https://cdn.guiademoteis.com.br/Images/itens-suites/secador-de-cabelo-04-09-2018-12-14.png"
              }
            ],
            "exibirQtdDisponiveis": true
          },
        ],
        "fantasia": "Motel Le Nid",
        "distancia": 28.27,
        "qtdFavoritos": 0,
        "qtdAvaliacoes": 2159
      }
    ],
    "pagina": 1,
    "maxPaginas": 1,
    "totalMoteis": 1,
    "totalSuites": 0,
    "qtdPorPagina": 10
  },
  "sucesso": true,
  "mensagem": []
};
