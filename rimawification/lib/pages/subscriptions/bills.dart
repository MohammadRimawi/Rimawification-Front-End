import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rimawification/themes/ColorsList.dart';

class billsPage extends StatefulWidget {
  const billsPage({Key? key}) : super(key: key);

  @override
  _billsPageState createState() => _billsPageState();
}

class _billsPageState extends State<billsPage> {
  var data = [
    {
      "date": DateTime(2021, DateTime.april, 22),
      "amount": 25,
      "currency": "dollar",
    },
    {
      "date": DateTime(2021, DateTime.may, 22),
      "amount": 25,
      "currency": "dollar",
    },
    {
      "date": DateTime(2021, DateTime.june, 22),
      "amount": 25,
      "currency": "dollar",
    },
    {
      "date": DateTime(2021, DateTime.july, 22),
      "amount": 25,
      "currency": "dollar",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double total = 0;
    String totalCurrency = "\$";
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == data.length) {
                return Container(
                  decoration: BoxDecoration(
                      color: ColorsList.deepPurple,
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 50),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          total.toString() + totalCurrency,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                DateTime date = DateTime.parse(data[index]['date'].toString());
                double amount = double.parse(data[index]['amount'].toString());
                String currency =
                    data[index]['currency'].toString().toLowerCase() == "dollar"
                        ? "\$"
                        : " JOD";

                total += amount;
                totalCurrency = currency;
                return Container(
                  decoration: BoxDecoration(
                      color: ColorsList.deepPurple[index % 2 * 100],
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 50),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('yyyy MMM dd').format(date),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          amount.toString() + currency,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
