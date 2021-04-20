import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'BathroomLights.dart';
import 'BedroomLights.dart';
import 'DatabaseSetUp/Database.dart';
import 'HomePage.dart';
import 'KitchenLights.dart';
import 'LivingRoomLights.dart';
import 'Model/User.dart';

class UserMenu extends StatefulWidget {
  final User user;
  const UserMenu(this.user);

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  DBProvider _dbProvider;


  @override
  void initState() {
    super.initState();
    setState(() {
      _dbProvider = DBProvider.dbProviderInstance;
    });
  }
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(mainAxisAlignment:MainAxisAlignment.start,children: [FaIcon(FontAwesomeIcons.home),Text('\t${widget.user.name}')],),

      ),
      body: Center(
      child:SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap:(){
                  print('Living Room');
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LivingRoomLights()));
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/livingRoom.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
              ),
            ),
          ),
            Text(
              'Σαλόνι',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap:(){
                  print('Bedroom');
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>BedRoomLights()));
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/bedRoom.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
              ),
            ),
            ),
            Text(
              'Υπνοδωμάτιο',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap:(){
                  print('Bathroom');
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>BathRoomLights()));
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/bathRoom.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                ),
              ),
            ),
            Text(
              'Μπάνιο',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap:(){
                  print('Kitchen');
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>KitchenLights()));
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/kitchen.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                ),
              ),
            ),
            Text(
              'Κουζίνα',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ],
        ),
    ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.transparent,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items:[
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.questionCircle),
                label: '',
                backgroundColor: Colors.grey
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label:'',
                backgroundColor: Colors.grey
            ),
          ],
          onTap: (val){
            setState(() {
              _currentIndex = val;
              if(_currentIndex == 0){
                _showMyDialog();
              }
              if(_currentIndex == 1){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyHomePage()),(Route<dynamic> route)=>false);
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
                Text('- Για να ανάψεις κάποιο φως επέλεξε δωμάτιο'),
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