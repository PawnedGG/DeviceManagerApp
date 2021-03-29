class User{
  static const colId ='id';
  static const colMail ='email';
  static const colName = 'name';
  static const colPswd ='password';

  int id;
  String email;
  String name;
  String password;

  User({this.id,this.email,this.name,this.password});

  User.fromMap(Map<String,dynamic> map){
    id = map[colId];
    email = map[email];
    name = map[colName];
    password = map[colPswd];
  }

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{'email':email,'name':name,'password':password};
    if(id!=null){
      map[colId]=id;
    }
    return map;
  }
}