import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:guia_moteis_app/core/errors/errors.dart';

import '../domain/errors/motels_failure.dart';
import '../domain/models/motels_result_model.dart';
import 'motel_repository.dart';
import 'package:http/http.dart' as http;

class MotelRepositoryImpl implements MotelRepository {
  final http.Client client;

  MotelRepositoryImpl(this.client);

  @override
  Future<Either<Failure, MotelsResultModel>> getMotels() async {
    try {
      final response = await client
          .get(Uri.parse('https://api.npoint.io/e728bb91e0cd56cc0711'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        return right(MotelsResultModel.fromJson(data));
      } else {
        throw GetFailureMotels(
          errorMessage:
              "Erro na API: ${response.reasonPhrase} Status: ${response.statusCode}",
        );
      }
    } on http.ClientException catch (e) {
      return Left(
          GetFailureMotels(errorMessage: "Falha ao se conectar à API. $e"));
    } on FormatException catch (e) {
      return Left(
        GetFailureMotels(
            errorMessage: "Erro ao processar os dados da resposta. $e"),
      );
    } catch (e) {
      return Left(GetFailureMotels(errorMessage: "Erro inesperado: $e"));
    }
  }
}
