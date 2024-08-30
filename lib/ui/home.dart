import 'dart:ui';

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:demo/model/currency_model.dart';
import 'package:demo/service/api_service.dart';
import 'package:demo/ui/components/all_currency_list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _selectedCurrency = "USD";

  ApiService apiService = ApiService();

  Widget _dropDownItem(Country country) => Container(
    child: Row(
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 20,),
        Text("${country.currencyName}")
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8,),
        Center(child: Text("Base Currency", style: TextStyle(color: Colors.white),)),
        SizedBox(height: 8,),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CountryPickerDropdown(
            initialValue: 'us',
            itemBuilder: _dropDownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _selectedCurrency = country?.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(height: 8,),
        Center(child: Text("All Currency", style: TextStyle(color: Colors.white),)),
        SizedBox(height: 8,),

        FutureBuilder<List<CurrencyModel>>(
          future: apiService.getLatest(_selectedCurrency),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CurrencyModel> currencyModelList = snapshot.data ?? [];
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AllCurrencyListItem(currencyModel: currencyModelList[index]);
                  },
                  itemCount: currencyModelList.length,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error occurred", style: TextStyle(color: Colors.white)),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
