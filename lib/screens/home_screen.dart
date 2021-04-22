import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: ListTile(
                        isThreeLine: true,
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(data.firstname.toString()),
                          ),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text("Firstname: ${data.firstname}"),
                            Text("Lastname: ${data.lastname}"),
                            Text("Phone number: ${data.phone}"),
                            Text("Address: ${data.address}"),
                            Text("Username: ${data.username}"),
                            //Text("Password: ${data.password}"),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
