import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:demo/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_curency_app/service/api_service.dart';

class Exchange extends StatefulWidget {
  const Exchange({Key? key}) : super(key: key);

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  String _selectedBaseCurrency = "USD";
  String _selectedTargetCurrency = "GBP";
  final _textController = TextEditingController();
  String _exchangeRate = "";
  ApiService apiService = ApiService();

  bool isVisible = false;

  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyName}"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Base Currency",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: CountryPickerDropdown(
                      initialValue: 'us',
                      itemBuilder: _buildCurrencyDropdownItem,
                      onValuePicked: (Country? country) {
                        print("${country?.name}");
                        setState(() {
                          isVisible = false;
                          _selectedBaseCurrency = country?.currencyCode ?? "";
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Target Currency",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: CountryPickerDropdown(
                      initialValue: 'GB',
                      itemBuilder: _buildCurrencyDropdownItem,
                      onValuePicked: (Country? country) {
                        print("${country?.name}");
                        setState(() {
                          isVisible = false;
                          _selectedTargetCurrency = country?.currencyCode ?? "";
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_textController.text.isNotEmpty) {
                          await apiService
                              .getExchange(
                                  _selectedBaseCurrency,
                                  _selectedTargetCurrency)
                              .then((result) {
                            if (result != null) {
                              isVisible = true;
                              double value =
                                  double.parse(_textController.text.toString());
                              double exchangeRate =
                                  double.parse(result[0].value.toString());
                              double total = value * exchangeRate;
                  
                              _exchangeRate = total.toStringAsFixed(2).toString();
                              setState(() {});
                            }
                          });
                        }
                      },
                      child: const Text("Exchange")),
                  const SizedBox(
                    height: 15,
                  ),
                  if (isVisible)
                    Text(
                      _exchangeRate + " " + _selectedTargetCurrency,
                      style: const TextStyle(
                          fontSize: 60, color: Colors.greenAccent),
                    )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}