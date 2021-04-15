import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DatabaseSetUp/Database.dart';
import 'Login.dart';
import 'SignUp.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numOfUsers = -1;
  DBProvider _dbProvider;


  void initState() {
    super.initState();
    setState(() {
      _dbProvider = DBProvider.dbProviderInstance;
      _countUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/app_icon.png"),
                  fit: BoxFit.cover
              )
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SmartApp',
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation
                    .centerFloat,
                floatingActionButton: new FloatingActionButton(
                  backgroundColor: Colors.blueGrey[700],
                  onPressed: () {
                    if (numOfUsers>=1)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    else
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                  },
                  child: new Icon(Icons.login),
                )
            )
        )
    );
  }

  _countUsers() async {
    int count = await _dbProvider.getCount();
    setState(() {
      numOfUsers = count;
    });
  }
}