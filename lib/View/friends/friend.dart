import 'package:meta/meta.dart';

class Friend {
  Friend({
    @required this.avatar,
    @required this.name,
    @required this.surname,
    @required this.bio,
    @required this.email,
    @required this.id,
    @required this.rol,
    @required this.location,
    @required this.nacionalidad,
    @required this.edad,
    @required this.sexo,
    @required this.pierna,
    @required this.peso,
    @required this.altura,
    @required this.position,
    @required this.photoPosition,
    @required this.historial,
  });

  final String avatar;
  final String name;
  final String surname;
  final String bio;
  final String email;
  final String location;
  final String nacionalidad;
  final String id;
  final String rol;
  final String edad;
  final String sexo;
  final String pierna;
  final String peso;
  final String altura;
  final String position;
  final String photoPosition;
  final String historial;


  /*static List<Friend> allFromResponse(String json) {
    return JSON
        .decode(json)['results']
        .map((obj) => Friend.fromMap(obj))
        .toList();
  }

  static Friend fromMap(Map map) {
    var name = map['name'];

    return new Friend(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      location: _capitalize(map['location']['state']),
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }*/
}
