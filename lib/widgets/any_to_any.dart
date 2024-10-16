// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:exchange_xpert/functions/convert_any_to_any.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnyToAny({super.key, this.rates, required this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String dropdownvalue1 = 'AUD';
  String dropdownvalue2 = 'INR';
  String result = 'Click "Convert" to see result';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Convert Any Currency',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const ValueKey('amount'),
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownvalue1,
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
                      dropdownvalue1 = newValue!;
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
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text('To'),
                ),
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownvalue2,
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
                      dropdownvalue2 = newValue!;
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
              ],
            ),
            const SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    result =
                        '${amountController.text} $dropdownvalue1 = ${convertanytoany(widget.rates, amountController.text, dropdownvalue1, dropdownvalue2)} $dropdownvalue2';
                  });
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 10),
            Container(child: Text(result)),
          ],
        ),
      ),
    );
  }
}
