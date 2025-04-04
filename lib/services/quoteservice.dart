import 'package:dio/dio.dart';

class QuoteService {
  Dio dio;

  QuoteService(this.dio);

  Future<List<dynamic>> getQuotes() async {

      Response response = await dio.get("http://api.quotable.io/quotes");
      return response.data['results'];

  }
}