import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/frienddetails/friend_details_page.dart';
import 'package:sportin/View/friends/friend.dart';

class Notificaciones extends StatefulWidget { 
  @override
  NotificacionesState createState() => new NotificacionesState();
}

class NotificacionesState extends State<Notificaciones> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/reactedannouncementnotification/$token"),
        headers : {
          "Accept": "application/json"
        }
      );
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: new Center(
        child: new FutureBuilder(
          future: _response,
          builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData)
              return new Text('Loading...');
            else if (response.data.statusCode != 200) {
              return new Text('Could not connect to User service.');
            } else {
              List json = jsonCodec.decode((response.data.body));
              return new NotificacionesData(json);
            }
          }
        )
      ),
    );
  }
}

class NotificacionesData extends StatelessWidget {
  final List data;
  NotificacionesData(this.data);

  final List<String> _nombre = new List<String>();
  final List<String> _oferta = new List<String>();
  final List<String> _photo = new List<String>();
  final List<int> _i = new List<int>();
  
  @override
  Widget build(BuildContext context){

    for(int i=0; i<data.length; i++) {
      _nombre.add(data[i]['userName']);
      _oferta.add(data[i]['description']);
      _photo.add(data[i]['profilePhoto']);
      _i.add(i);
    }

    void _popUp(int index) async{
      List<String> _nombre = new List<String>();
      List<String> _bio = new List<String>();
      List<String> _historial = new List<String>();
      List<String> _reactedId = new List<String>();
      List<String> _userId = new List<String>();
      List <String> _photoPopIp = new List<String>();

      _nombre.add(data[index]['userName']);
      _bio.add(data[index]['bio']);
      _historial.add(data[index]['historial']);
      _reactedId.add(data[index]['reactedAnnouncementId']);
      _userId.add(data[index]['userId']);
      _photoPopIp.add(data[index]['photo']);
    //------------------------------------------------------------------
    
    Friend friend = new Friend(avatar: data[index]['profilePhoto'], name: data[index]['userName'], surname:data[index]['surname'] , bio:data[index]['bio'],  email: 'adonis@gmail.com', location: data[index]['populationName'], id:data[index]['userId'], rol: data[index]['roleId'], 
                                               edad: data[index]['birthDate'], sexo:data[index]['sex'], pierna: data[index]['foot'], peso:data[index]['weight'], altura: data[index]['height'],
                                               position: data[index]['playerPositionName'], photoPosition: data[index]['photoPosition'], historial:data[index]['historial'], nacionalidad:data[index]['countryName']);
    print('---------------');
    print(friend.avatar);
    Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (c) {
                  return new FriendDetailsPage(friend, 'otro', data[index]['reactedAnnouncementId'],  avatarTag: 1,);
                },
              ),
            );
   /*         
      Widget photoSection =  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new MemoryImage(base64Decode(data[0]['profilePhoto'])),
            ),
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        )
      ],
    );

    Widget nacionalidad =  new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 20.0,
          width: 20.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/nacionalidad.png'),
            ),
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['countryName']} ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );

    Widget localidad =  new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 20.0,
            width: 20.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/localidad.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['populationName']} ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );

    Widget nameSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          new Text(
            '${data[0]['userName']}',// ${data[0]['surname']}
            style: new TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ) 
    );
    
    Widget clubSection = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Equipo actual',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text(
            '${data[0]['ClubName']}',
            style: new TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
    
    Widget positionSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Posición',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['playerPositionName']}',
            style: new TextStyle(
              color: Colors.grey[500],
            ),
            softWrap: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    image: new MemoryImage(base64Decode(data[0]['photoPosition'])),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    Widget descriptionSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Historial',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['historial']}',
            style: new TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
            softWrap: true,
          ),
        ],
      ),
    );

    Widget biographySection = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Biografia',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['bio']}',
            style: new TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
            softWrap: true,
          ),
        ],
      ),
    );

    Widget altura = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 20.0,
            width: 20.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/altura.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['height']} cm ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );
    
    Widget peso = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 20.0,
            width: 20.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/peso.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['weight']} kg ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );

    Widget sexo = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 20.0,
            width: 20.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/sex.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['sex']} ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );

    Widget pierna = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 20.0,
            width: 20.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/foot.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['foot']} ⎢',
          style: new TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );

    Widget vacio = new Text('');

    Widget alturaN() {
      if(data[0]['height']!=null) {
        return altura;
      }
      else return vacio;
    } 

    Widget pesoN() {
      if(data[0]['weight']!=null) {
        return peso;
      }
      else return vacio;
    } 

    Widget sexoN() {
      if(data[0]['sex']!=null) {
        return sexo;
      }
      else return vacio;
    } 

    Widget piernaN() {
      if(data[0]['foot']!=null) {
        return pierna;
      }
      else return vacio;
    } 

    Widget clubN() {
      String club = data[0]['clubId'];
      int idClub = int.parse('$club');
      if(idClub!=1) {
        return clubSection;
      }
      else return vacio;
    } 

    Widget positionN() {
      String position = data[0]['playerPositionId'];
      int idPosition = int.parse('$position');
      assert(idPosition is int);
      if(idPosition!=100) {
        return positionSection;
      }
      else return vacio;
    } 
  
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('${_nombre[0]}'),
            content: new Column(
              children: [
                new Row(
                  children: <Widget>[
                    photoSection,
                    positionN(),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    nacionalidad,
                    localidad,
                    sexoN(),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    alturaN(),
                    pesoN(),
                    piernaN(),
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                clubN(),
                descriptionSection,
                biographySection,
              ],
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.thumb_down),
                color: Colors.redAccent,
                iconSize: 50.0,
                tooltip: 'Cancel',
                onPressed: () {_submit(_reactedId[0], 1,_userId[0]);},
              ),
              new IconButton(
                icon: new Icon(Icons.thumb_up),
                color: Colors.greenAccent,
                iconSize: 50.0,
                tooltip: 'Me Interesa',
                onPressed: () {_submit(_reactedId[0], 2,_userId[0]);},
              )
            ],
          );
        }
      );
    }
    */
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notificaciones"),
        automaticallyImplyLeading: false, 
        backgroundColor: color_appbar,
      ),
      backgroundColor: color_background,
      body: new ListView.builder(
        itemCount: _nombre.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    onTap: null,
                    leading: new Hero(
                      tag: index,
                      child: new CircleAvatar(
                        backgroundImage: new MemoryImage(base64Decode(_photo[index])),
                      ),
                    ),
                    title: new Text('${_nombre[index]}', style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    subtitle: new Text('A ${_nombre[index]} le ha interesado tu oferta -${_oferta[index]}-, clica a Ver perfil para ver su perfil.',),
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(left: 55.0),
                        child: new FlatButton(
                          onPressed: () {_popUp(_i[index]);},
                          child: new Text('Ver perfil',
                            style: new TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20.0,),
                              )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

