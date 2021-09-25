import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rimawification/components/navdrawer.dart';
import 'package:rimawification/pages/subscriptions/bills.dart';
import 'package:rimawification/themes/ColorsList.dart';

class subscriptionsPage extends StatefulWidget {
  const subscriptionsPage({Key? key}) : super(key: key);

  @override
  _subscriptionsPageState createState() => _subscriptionsPageState();
}

class _subscriptionsPageState extends State<subscriptionsPage> {
  var data = [
    {
      "title": "Contabo Server VPS",
      "date": DateTime(2021, DateTime.august, 22),
      "every": "monthly",
      "amount": 6.99,
      "currency": "Dollar"
    },
    {
      "title": "Rimawi.me",
      "date": DateTime(2021, DateTime.may, 7),
      "every": "yearly",
      "amount": 2.98,
      "currency": "Dollar"
    },
    {
      "title": "Skill Share",
      "date": DateTime(2021, DateTime.july, 15),
      "every": "yearly",
      "amount": 29.88,
      "currency": "Dollar"
    },
    {
      "title": "Spotify Premium",
      "date": DateTime(2021, DateTime.january, 26),
      "every": "monthly",
      "amount": 4.99,
      "currency": "Dollar"
    },
    {
      "title": "Spreaker",
      "date": DateTime(2021, DateTime.july, 14),
      "every": "monthly",
      "amount": 25,
      "currency": "Dollar"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Subscriptions"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            DateTime date = DateTime.parse(data[index]['date'].toString());
            DateTime now = DateTime.now();

            double amount = double.parse(data[index]['amount'].toString());
            String every;

            if (data[index]['every'].toString().toLowerCase() == "monthly") {
              every = "Month";
            } else if (data[index]['every'].toString().toLowerCase() ==
                    "yearly" ||
                data[index]['every'].toString().toLowerCase() == "annually") {
              every = "Year";
            } else {
              every = data[index]['every'].toString();
            }
            String currency =
                data[index]['currency'].toString().toLowerCase() == "dollar"
                    ? "\$"
                    : " JOD";

            // int diffYears = now.year - date.year;

            // DateTime diff = now.

            int days = now.difference(date).inDays;
            int years = (days / 365).floor();
            int months = (days / 31).floor();
            DateTime next;
            if (every.toLowerCase() == "year") {
              next = DateTime(date.year + years + 1, date.month, date.day);
            } else {
              next = DateTime(date.year, date.month + months + 1, date.day);
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFf6f6f6),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  // backgroundColor: Colors.amber,
                  // backgroundColor: ,
                  // initiallyExpanded: true,
                  trailing: Text(
                    amount.toString() + currency,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,

                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['title'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text("Next on: " +
                                DateFormat('yyyy MMM dd').format(next)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFe5e5e5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Starting Date: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('yyyy MMM dd').format(
                                DateTime(date.year, date.month, date.day)),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(color: Color(0xFFe5e5e5)),
                      child: Row(
                        children: [
                          Text(
                            "Next on: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('yyyy MMM dd').format(next),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(color: Color(0xFFe5e5e5)),
                      child: Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            amount.toString() + currency + "\\" + every,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(color: Color(0xFFe5e5e5)),
                      child: Row(
                        children: [
                          Text(
                            "Been subscribed for: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (every.toLowerCase() == "year"
                                ? (years + 1).toString() + " Years"
                                : (months + 1).toString() + " Months"),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(color: Color(0xFFe5e5e5)),
                      child: Row(
                        children: [
                          Text(
                            "Paid till now: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (amount *
                                        (every.toLowerCase() == "year"
                                            ? years + 1
                                            : months + 1))
                                    .toString() +
                                currency,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return billsPage();
                                }));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_balance_wallet_rounded),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Bills'),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorsList.indigo,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text("Renew"),
                                          content: Container(
                                            height: 200,
                                            // width: double.infinity,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      labelText: 'Amount paid',
                                                      prefixIcon: Icon(Icons
                                                          .attach_money_outlined)),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.blue),
                                                  onPressed: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2018),
                                                      lastDate: DateTime(2025),
                                                    ).then((DateTime? value) {
                                                      if (value != null) {
                                                        DateTime _fromDate =
                                                            DateTime.now();
                                                        _fromDate = value;
                                                        final String date =
                                                            DateFormat.yMMMd()
                                                                .format(
                                                                    _fromDate);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Selected date: $date')),
                                                        );
                                                      }
                                                    });
                                                  },
                                                  child: const Text(
                                                      'Date Picker Dialog'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Canel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Renew"),
                                            ),
                                          ],
                                        ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.payment),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Renew'),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorsList.indigo,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
