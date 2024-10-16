// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:exchange_xpert/functions/convert_usd_to_any.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({super.key, this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownvalue = 'AUD';
  String result = 'Click "Convert" to see result';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Convert USD to any currency',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('usd'),
              controller: usdController,
              decoration: const InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownvalue,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.amber,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                const SizedBox(width: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result =
                            '${usdController.text} USD = ${convertusdtoany(widget.rates, usdController.text, dropdownvalue)} $dropdownvalue';
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: const Text('Convert'),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Container(child: Text(result)),
          ],
        ),
      ),
    );
  }
}
