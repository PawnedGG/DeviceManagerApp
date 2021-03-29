import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'DatabaseSetUp/Database.dart';
import 'Model/User.dart';
import 'UserMenu.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  User _user = User();
  DBProvider _dbProvider;
  final _ctrlName = TextEditingController();
  final _ctrlMail = TextEditingController();
  final _ctrlPasscode = TextEditingController();

  @override
  void initState(){
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
        title: Text('Εγγραφή'),
      ),
      body: _signUpForm(),
    );
  }

  _signUpForm() =>Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _ctrlMail,
              decoration: InputDecoration(labelText: 'E-mail',labelStyle:TextStyle(color: Colors.white)),
              onSaved: (val)=>setState(()=>_user.email=val),
              validator: (val)=>(val.length==0 ? 'Μη έγκυρο e-mail':null),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _ctrlName,
              decoration: InputDecoration(labelText: 'Όνομα Χρήστη',labelStyle:TextStyle(color: Colors.white)),
              onSaved: (val)=>setState(()=>_user.name=val),
              validator: (val)=>(val.length==0 ? 'Μη έγκυρο όνομα χρήστη':null),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _ctrlPasscode,
              decoration: InputDecoration(labelText: 'Κωδικός Πρόσβασης',labelStyle:TextStyle(color: Colors.white)),
              onSaved: (val)=>setState(()=>_user.password=val),
              validator: (val)=>(val.length==0 ? 'Μη έγκυρος κωδικός πρόσβασης':null),
              obscureText: true,
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text('Εγγραφή'),
                onPressed: (){
                  _onSubmit();
                },
                color: Colors.blueGrey[200],
                textColor: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: Text('Ακύρωση'),
                onPressed: (){
                  _ctrlPasscode.clear();
                  _ctrlName.clear();
                  _formKey.currentState.reset();
                },
                color: Colors.blueGrey[200],
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      )
  );

  _onSubmit() async{
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if(_user.id==null) await _dbProvider.insertUser(_user);
      else print('error');
      _gotoUserMenu();
      _sendWelcomeMail(_user);
    }
  }

  _gotoUserMenu(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserMenu(_user)),(Route<dynamic> route)=>false);
  }

  _sendWelcomeMail(User _receiver) async{
    String username = 'smart.manager.app.uniwa@gmail.com';
    String password = 'smartmanager2021App';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(_receiver.email)
      ..subject = 'Καλως ήρθατε στο SmartApp! ${DateTime.now()}'
      ..text = 'Αγαπητέ χρήστη ${_receiver.name},'
          '\n\nΑυτό είναι ένα απλό μήνυμα καλωσορίσματος .'
          '\n\n Με την εγγραφή σας μας κάνατε ακόμα αρκετά χαρούμενους .'

          '\n\n\n Με εκτίμηση  😀';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}