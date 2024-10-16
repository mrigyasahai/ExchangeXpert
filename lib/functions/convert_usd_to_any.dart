String convertusdtoany(Map exchangerates, String usd, String currency) {
  double result = double.parse(usd) * exchangerates[currency];
  return result.toStringAsFixed(2);
}
