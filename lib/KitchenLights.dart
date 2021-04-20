import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DatabaseSetUp/Database.dart';
import 'HomePage.dart';

bool LampIsSwitched=false;
class KitchenLights extends StatefulWidget {
  @override
  _KitchenLights createState() => _KitchenLights();
}

class _KitchenLights extends State<KitchenLights> {
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
        title: Text('Κουζίνα'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap:(){
                    print('Κεντρικό φως');
                  },
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/light_on.jpg"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '              Κεντρικό Φως        ',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: LampIsSwitched,
                    onChanged: (value){
                      setState(() {
                        LampIsSwitched=value;
                        print(LampIsSwitched);
                      });
                    },
                    activeColor: Colors.orangeAccent,
                    activeTrackColor: Colors.yellow,
                  )
                ],
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
                Text('- Για να ανάψεις κάποια επέλεξε την '),
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