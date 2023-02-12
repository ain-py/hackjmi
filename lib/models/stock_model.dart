import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    //await Future<void>.delayed(Duration(seconds: 1));
    var res = await http.get(
        Uri.parse('https://www.nseindia.com/api/search/autocomplete?q=$query'));
    print(res.body);
    if (res.statusCode == 200) {
      var deco = jsonDecode(res.body);
      List sym = deco['symbols'];
      List<Map<String, String>> itemSend = [];
      sym.forEach((element) {
        itemSend
            .add({'name': element['symbol_info'], 'symbol': element['symbol']});
      });
      return itemSend;
    } else {
      throw Exception('Failed to load');
    }
  }
}
