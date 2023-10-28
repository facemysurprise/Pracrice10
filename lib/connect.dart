import 'package:dio/dio.dart';
import 'package:flutter_ais_bottombar/data.dart';
import 'api_service.dart';

Future<List<Photo>> fetchPhotos() async {
  Dio dio = Dio();
  final apiService = ApiService(dio);

  try {
    return await apiService.getPhotos();
  } catch (error) {
    throw Exception("Ошибка при загрузке данных");
  }
}
