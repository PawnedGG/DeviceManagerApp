import 'package:smart_manager/Model/Room.dart';

class Light{
  static const colId ='id';
  static const colName = 'name';
  static const colRoom = 'room';
  static const colstate = 'state';

  int id;
  String name;
  Room room;
  bool state;

  Light({this.id,this.name,this.room,this.state});

  Light.fromMap(Map<String,dynamic> map){
    id = map[colId];
    name = map[colName];
    room = map[colRoom];
    state = map[colstate];
  }

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{'name':name,'room':room,'state':state};
    if(id!=null){
      map[colId]=id;
      map[colRoom]=room.name;
      map[colstate]= state;
    }
    return map;
  }
}