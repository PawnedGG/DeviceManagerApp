import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HomePage.dart';
class NewRoom extends StatefulWidget{
  @override
  _NewRoom createState() => _NewRoom();

}
class _NewRoom extends State<NewRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Νέο Δωμάτιο"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  "),
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.transparent,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.questionCircle),
                label: '',
                backgroundColor: Colors.grey
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: '',
                backgroundColor: Colors.grey
            ),
          ],
          onTap: (val) {
            setState(() {
              if (val == 0) {
                _showMyDialog();
              }

              if (val == 1) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()), (
                        Route<dynamic> route) => false);
              }
            });
          }
      ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Μάλλον χρειάζεσαι βοήθεια...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('- Για να προσθέσεις δωμάτιο συμπλήρωσε τη φόρμα και μετα ΟΚ'),
                Text('- Για να αποσυνδεθείς πάτα το κάτω δεξιά σύμβολο'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


