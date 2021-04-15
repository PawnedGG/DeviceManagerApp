class Room{
  static const colId ='id';
  static const colName = 'name';

  int id;
  String name;

  Room({this.id,this.name});

  Room.fromMap(Map<String,dynamic> map){
    id = map[colId];
    name = map[colName];
  }

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{'name':name};
    if(id!=null){
      map[colId]=id;
    }
    return map;
  }
}