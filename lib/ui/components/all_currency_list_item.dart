import 'package:demo/model/currency_model.dart';
import 'package:flutter/material.dart';

class AllCurrencyListItem extends StatelessWidget {
  const AllCurrencyListItem({Key?key,required this.currencyModel}):super(key: key);

  final CurrencyModel currencyModel;
  //const AllCurrencyListItem({Key?key,this.currencyModel}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue.withAlpha(88)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currencyModel.code.toString(),style: TextStyle(color: Colors.white,fontSize: 17)),
          Text(currencyModel.value?.toStringAsFixed(2).toString() ??"",style: TextStyle(color: Colors.white,fontSize: 17)),

        ],
      ),
    );
  }
}