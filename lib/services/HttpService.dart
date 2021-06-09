import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prova_n2/models/Result.dart';

class HttpService {
  Future<Result> getDados() async {
    final url = Uri.parse('https://api.covid19api.com/summary');

    var response = await http.get(url);
    var responseParsed = parseResponse(response.body);
    return responseParsed;
  }

  Result parseResponse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return Result.fromJson(parsed);
  }
}
