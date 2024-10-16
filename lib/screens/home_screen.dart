import 'package:exchange_xpert/models/exchange_rate_model.dart';
import 'package:exchange_xpert/services/currency_service.dart';
import 'package:exchange_xpert/services/exchange_rate_service.dart';
import 'package:exchange_xpert/widgets/any_to_any.dart';
import 'package:exchange_xpert/widgets/usd_to_any.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currencyService = CurrencyService();
  final exchangeRateService = ExchangeRateService();

  late Future<Exchangerate> rates;
  late Future<Map> allCurrencies;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      rates = exchangeRateService.fetchRates();
      allCurrencies = currencyService.fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExchangeXpert',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/app_bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: FutureBuilder<Exchangerate>(
              future: rates,
              builder: (context, ratesSnapshot) {
                if (ratesSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (ratesSnapshot.hasError) {
                  return Center(child: Text('Error: ${ratesSnapshot.error}'));
                }
                return FutureBuilder<Map>(
                  future: allCurrencies,
                  builder: (context, currenciesSnapshot) {
                    if (currenciesSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (currenciesSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${currenciesSnapshot.error}'));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UsdToAny(
                          currencies: currenciesSnapshot.data!,
                          rates: ratesSnapshot.data!.rates,
                        ),
                        AnyToAny(
                          rates: ratesSnapshot.data!.rates,
                          currencies: currenciesSnapshot.data!,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
