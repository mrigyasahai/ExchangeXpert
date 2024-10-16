String convertanytoany(
    Map exchangerates, String amount, String from, String to) {
  double result =
      double.parse(amount) * (exchangerates[to] / exchangerates[from]);
  return result.toStringAsFixed(2);
}

/*
1 USD = x AUD = z INR   |  1 AUD = z/x INR
x AUD = 1 USD           |  8 AUD = 8 * z/x INR
1 AUD = 1/x USD         |
y AUD = y * (1/x) USD   |

*/