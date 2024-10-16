// ignore_for_file: unused_import

import 'dart:convert';
import 'package:exchange_xpert/utils/key.dart';
import 'package:http/http.dart' as http;
import 'package:exchange_xpert/models/allcurrencies_model.dart';

class CurrencyService {
  final String baseURL = 'https://openexchangerates.org/api/currencies.json';
  Future<Map> fetchCurrencies() async {
    try {
      final response = await http.get(Uri.parse('$baseURL?app_id=$apiKey'));
      if (response.statusCode == 200) {
        final allCurrencies = allCurrenciesFromJson(response.body);
        return allCurrencies;
        // Map jsonData = json.decode(response.body);
        // return jsonData;
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      throw Exception('Error fetching currencies');
    }
  }
}
