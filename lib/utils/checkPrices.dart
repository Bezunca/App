import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> checkAssetPrice(String ticker) async {
  final response = await http
      .get("http://192.168.0.173:8080/fetch_quotation?tickers=${ticker[0]}");
  if (response.statusCode == 200) {
    print("okokokokokokokokokok funcionou");
    List<dynamic> data = jsonDecode(response.body);
    return (data[0]["Price"] * 100).floor();
  } else {
    return 0;
  }
}
