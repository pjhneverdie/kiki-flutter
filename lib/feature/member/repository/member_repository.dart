import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/common/dto/api_response.dart';
import 'package:kiki/feature/member/model/member.dart';

@singleton
class MemberRepository {
  final Dio _dio;

  MemberRepository(this._dio);

  Future<ApiResponse<Member>> me() async {
    final Response response = await _dio.get(
      "/member/me",
      options: Options(
        headers: {
          "Authorization": true,
        },
      ),
    );

    final ApiResponse<Member> data = ApiResponse<Member>.fromJson(
      response.data,
      (json) => Member.fromJson(json as Map<String, dynamic>),
    );

    return data;
  }

  Future<ApiResponse<Void>> deleteMember() async {
    final Response response = await _dio.delete(
      "/member",
      options: Options(
        headers: {
          "Authorization": true,
        },
      ),
    );

    return ApiResponse<Void>(
      codeName: response.data["codeName"] as String,
      value: null,
    );
  }
}
