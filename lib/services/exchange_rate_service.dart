// ignore_for_file: unused_import

import 'dart:convert';
import 'package:exchange_xpert/models/exchange_rate_model.dart';
import 'package:exchange_xpert/utils/key.dart';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  final String baseURL = 'https://openexchangerates.org/api/latest.json';

  Future<Exchangerate> fetchRates() async {
    try {
      final response = await http.get(Uri.parse('$baseURL?app_id=$apiKey'));
      if (response.statusCode == 200) {
        final exchangerate = exchangerateFromJson(response.body);
        return exchangerate;
      } else {
        throw Exception('Failed to load rates');
      }
    } catch (e) {
      throw Exception('Error fetching rates.');
    }
  }
}
