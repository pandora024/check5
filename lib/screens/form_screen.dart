import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  // controller
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: "ชื่อ"),
                    autofocus: false,
                    controller: firstnameController,
                    validator: (String str) {
                      //ชื่อรายการเป็นค่าว่าง
                      if (str.isEmpty) {
                        return "กรุณาป้อนชื่อ";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "นามสกุล"),
                    autofocus: false,
                    controller: lastnameController,
                    validator: (String str) {
                      //ชื่อรายการเป็นค่าว่าง
                      if (str.isEmpty) {
                        return "กรุณาป้อนนามสกุล";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "เบอร์โทรศัพท์"),
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "กรุณาป้อนหมายเลข";
                      }
                      if (double.parse(str) <= 10) {
                        return "กรุณาป้อนตัวเลข 10 ตัว";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "ที่อยู่"),
                    autofocus: false,
                    controller: addressController,
                    validator: (String str) {
                      //ชื่อรายการเป็นค่าว่าง
                      if (str.isEmpty) {
                        return "กรุณาป้อนที่อยู่";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "E-mail"),
                    autofocus: false,
                    controller: usernameController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "กรุณาป้อน Email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Password"),
                    controller: passwordController,
                    obscureText: true,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "กรุณาป้อน Password";
                      }
                      if (double.parse(str) <= 8) {
                        return "กรุณาป้อนตัวเลขมากกว่าหรือเท่ากับ 10";
                      }
                      return null;
                    },
                  ),
                  FlatButton(
                    child: Text("Register"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        var firstname = firstnameController.text;
                        var lastname = lastnameController.text;
                        var phone = phoneController.text;
                        var address = addressController.text;
                        var username = usernameController.text;
                        var password = passwordController.text;
                        //เตรียมข้อมูล
                        Transactions statement = Transactions(
                            firstname: firstname,
                            lastname: lastname,
                            phone: phone,
                            address: address,
                            username: username,
                            password: password,
                            date: DateTime.now()); //object

                        //เรียก Provider
                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return MyHomePage();
                                }));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
