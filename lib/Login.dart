import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DatabaseSetUp/Database.dart';
import 'HomePage.dart';
import 'Model/User.dart';
import 'UserMenu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  User _user = User();
  DBProvider _dbProvider;
  final _ctrlName = TextEditingController();
  final _ctrlPasscode = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbProvider = DBProvider.dbProviderInstance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Είσοδος'),
      ),
      body: _loginForm(),
    );
  }

  _loginForm() =>
      Container(
          //color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _ctrlName,
                  decoration: InputDecoration(labelText: 'Όνομα Χρήστη',
                      labelStyle: TextStyle(color: Colors.white)),
                  onSaved: (val) => setState(() => _user.name = val),
                  validator: (val) =>
                  (val.length == 0
                      ? 'Μη έγκυρο όνομα χρήστη'
                      : null),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _ctrlPasscode,
                  decoration: InputDecoration(labelText: 'Κωδικός Πρόσβασης',
                      labelStyle: TextStyle(color: Colors.white)),
                  onSaved: (val) => setState(() => _user.password = val),
                  validator: (val) =>
                  (val.length == 0
                      ? 'Μη έγκυρος κωδικός πρόσβασης'
                      : null),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: ButtonTheme(
                          minWidth: 130.0,
                          height: 50.0,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            child: Text('Σύνδεση'),
                            onPressed: () {
                              _onSubmit();
                            },
                            color: Colors.blueGrey[200],
                            textColor: Colors.white,
                          ),
                        )
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text('Άκυρο'),
                    onPressed: () {
                      _clearAll();
                    },
                    color: Colors.blueGrey[200],
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
      );

  _clearAll() {
    _ctrlPasscode.clear();
    _ctrlName.clear();
    _formKey.currentState.reset();
  }

  _onSubmit() async {
    var form = _formKey.currentState;
    int id = -1;
    if (form.validate()) {
      form.save();
      try {
        await _dbProvider.query(_user.name, _user.password);
        _gotoUserMenu();
      } catch (e) {
        try {
          id = await _dbProvider.queryUserByName(_user.name);
          if (id != null)
            _showAlert();
        } catch (e) {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => MyHomePage()), (
              Route<dynamic> route) => false);
        }
      }
    }
  }

  _gotoUserMenu() {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => UserMenu(_user)), (
        Route<dynamic> route) => false);
  }


  _showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ωχ...'),
            content: Text(
                'Φαίνεται πως έχεις λογαριασμό αλλά μάλλον δεν έβαλες κάτι σωστά στα πεδία!'),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Θα ξαναπροσπαθήσω'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}