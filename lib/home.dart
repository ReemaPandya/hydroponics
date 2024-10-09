import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponics/login.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_row.dart';
class HomePage extends StatefulWidget {
 // final Data data;
  final String recordName;
  const HomePage(this.recordName);
 // HomePage({Key key, this.data}) : super(key: key);

 // final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FlutterLocalNotificationsPlugin fltrNotification;
 // String _selectedParam;
  String task;
  int val;
  final databaseReference =FirebaseDatabase.instance.reference();
  final fb = FirebaseDatabase.instance;
  bool isLoading = false;
  double d=0;
  int _currentSliderValue=0;
  String sliderValue;
  String value,humidity,temperature,waterTemperature,pH,tds,waterLevel,fire,relay,mosquitoes,insects,relay2,water,pesticide;
  String temp;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  Future getData()async{
    setState(() {
      isLoading = true;
    });

    databaseReference.child('Users').child(widget.recordName).child('name').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
         value= snapshot.value;
        print('name is $value');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('humidity').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        humidity= snapshot.value.toString();
        print('humidity is ${humidity.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('waterTemperature').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        waterTemperature= snapshot.value.toString();
        print('name is ${waterTemperature.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('temperature').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        temperature= snapshot.value.toString();
        print('name is ${temperature.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('pH').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        pH= snapshot.value.toString();
        print('pH is ${pH.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('relay').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        relay= snapshot.value.toString();
        print('relay is ${relay.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('relay2').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        relay2= snapshot.value.toString();
        print('relay2 is ${relay2.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('waterSprinkler').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        water= snapshot.value.toString();
        print('water sprayed ${water.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('pesticideSprayer').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        pesticide= snapshot.value.toString();
        print('pesticide sprayer ${pesticide.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('TDS').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        tds= snapshot.value.toString();
        print('tds is ${tds.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('waterLevel').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        waterLevel= snapshot.value.toString();
        print('Water Level is ${waterLevel.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('mosquito').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        mosquitoes= snapshot.value.toString();
        print('mosquitoes ${mosquitoes.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('insects').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        insects= snapshot.value.toString();
        print('insects ${insects.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('flame').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        fire= snapshot.value.toString();
        print('fire ${fire.toString()}');
      });
    });
    databaseReference.child('Users').child(widget.recordName).child('light').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
//        print(snapshot.value.toInt());
//        print(snapshot.value.toInt().runtimeType);
      sliderValue=snapshot.value;
      d=double.parse(sliderValue);
//        _currentSliderValue = snapshot.value;
//        d =_currentSliderValue.toDouble();
        print('light is $_currentSliderValue');
      });
    });
//    databaseReference.child('logs').child('message').onValue.listen((event) {
//      var snapshot = event.snapshot;
//      setState(() {
//        value = snapshot.value;
//        print('Value is $value');
//      });
//    });
//    databaseReference.child('logs').child('light').onValue.listen((event) {
//      var snapshot = event.snapshot;
//      setState(() {
//        _currentSliderValue = snapshot.value;
//
//        d =_currentSliderValue.toDouble();
//        print('light is $_currentSliderValue');
//      });
//    });
    setState(() {
      isLoading=false;
    });
  }

  Future _showNotificationWithDefaultSound(String  message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Alert!',
      message,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  Future _showNotificationWithDefaultSoundFire(String  message) async {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.Max, priority: Priority.High);
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Alert!',
        message,
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    }

  @override
  void initState(){
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: onSelectNotification);
    getData();
    firebaseMessaging.configure(
      onLaunch: (Map<String,dynamic> msg){
        print("onLaunch called");
      },
      onResume: (Map<String,dynamic> msg){
        print("onResume called");
      },
      onMessage: (Map<String,dynamic> msg){
        print("onMessage called");
      },
    );

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings) {
      print('IOS setting Registered');
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });
    super.initState();

  }
  update(String token){
    print(token);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    final ref = fb.reference().child("logs");
    final ref = fb.reference().child('Users').child(widget.recordName);
    String message;
    //int h;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydroponics'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userId');
              _signOut(context);
//              Navigator.pushNamed(context, AddVillage.routeName);
            },
          ),
//          Padding(
//            padding: const EdgeInsets.only(right: 10),
//            child: IconButton(
//              icon: Icon(Icons.search),
//              color: Colors.white,
//              onPressed: closeSearch,
//            ),
//          )
        ],
      ),
      body: //isLoading?CircularProgressIndicator:
      SingleChildScrollView(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('name').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('name').once().then((DataSnapshot snapshot) {
                      message = snapshot.value;
                      print('Value is $message');
                    });
                    return Text("Welcome ${value.toString()}!",
                     // value.toString()==null?'null':value.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('humidity').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('humidity').once().then((DataSnapshot snapshot) {
//                  h = snapshot.value;
//                  print('Value is $h');
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Humidity', "${humidity.toString()}%"),
                    );
//                      Text("Humidity :${humidity.toString()}%",
//                      // value.toString()==null?'null':value.toString(),
//                      textAlign: TextAlign.left,
//                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('temperature').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('temperature').once().then((DataSnapshot snapshot) {
//                  message = snapshot.value;
//                  print('Value is $message');
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Temperature', "${temperature.toString()}C"),
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('waterTemperature').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('waterTemperature').once().then((DataSnapshot snapshot) {
//                  message = snapshot.value;
//                  print('Value is $message');
                    if(double.parse(waterTemperature)>26){
                      _showNotificationWithDefaultSound("Water Temperature is too high!");
                    }
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Water Temperature', "${waterTemperature.toString()}C"),
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('pH').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('pH').once().then((DataSnapshot snapshot) {
//                  message = snapshot.value;
//                  print('Value is $message');
                    });
                    if(double.parse(pH)<5.5 || double.parse(pH)>6.5)
                      {
                        _showNotificationWithDefaultSound("Critical water pH level detected!");
                      }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('pH', "${pH.toString()}"),
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('TDS').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('TDS').once().then((DataSnapshot snapshot) {
                    });
//                    if(double.parse()<5.5 || double.parse(pH)>6.5)
//                    {
//                      _showNotificationWithDefaultSound("Critical water pH level detected!");
//                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('TDS', "${tds.toString()}"),
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('waterLevel').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('waterLevel').once().then((DataSnapshot snapshot) {
                    });
                    if(waterLevel=='25'){
                      _showNotificationWithDefaultSound("Water Tank is about to get emptied!");
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Water Level', "${waterLevel.toString()}cm"),
                    );
                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('flame').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('flame').once().then((DataSnapshot snapshot) {
                    });
                    if(fire=='true'){
                      _showNotificationWithDefaultSoundFire("Caution! Fire detected!");
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Fire Detected', fire=='true'?"Yes": "No"),
                    );

                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('mosquito').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('mosquito').once().then((DataSnapshot snapshot) {
                    });
                    if(int.parse(mosquitoes)!=0){
                      _showNotificationWithDefaultSound("Mosquitoes detected!");
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Mosquitoes Detected', "${mosquitoes.toString()}"),
                    );

                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('insects').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('frequencyFlag').child('insects').once().then((DataSnapshot snapshot) {
                    });
                    if(int.parse(insects)!=0){
                      _showNotificationWithDefaultSound("Insects detected!");
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Insects Detected', "${insects.toString()}"),
                    );

                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('waterSprinkler').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('waterSprinkler').once().then((DataSnapshot snapshot) {
                    });
                   
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Water Sprayed at', "${water.toString().substring(0,10)}"),
                    );

                  }
              ),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('pesticideSprayer').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('pesticideSprayer').once().then((DataSnapshot snapshot) {
                    });

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildRow('Pesticide sprayed at', "${pesticide.toString().substring(0,10)}"),
                    );

                  }
              ),
              Text("Adjust light",textAlign: TextAlign.left,),
              SliderTheme(
                data: SliderThemeData(

                    thumbColor: Colors.green,),
                child: Slider(
                    value: d,
                    min: 0,
                    max: 1023,
                    divisions: 1022,
                    // label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value.toInt();
                        String setVal=_currentSliderValue.round().toString();
                        //  int light = _currentSliderValue.toInt();
                        ref.child("light").set(setVal);
                      });}),
              ),
              Text("Spray Pesticides",textAlign: TextAlign.left,),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('relay').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('relay').once().then((DataSnapshot snapshot) {
                    });
                    return  ElevatedButton(

                      child: Text(relay=="ON"?"OFF":"ON",style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: Colors.green,
                        // letterSpacing: 0.84,
                        fontWeight: FontWeight.w700,
                      ),),
                      onPressed: () {
                        DateTime dateTime= DateTime.now();
                        relay=="ON"?ref.child("relay").set("OFF"):ref.child("relay").set("ON");
                        ref.child("pesticideSprayer").set(dateTime.toIso8601String());
                        //ref.child("waterSprinkler").set(dateTime.toIso8601String());
                       //_showNotification();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    );
                  }
              ),
              Text("Sprinkle Water",textAlign: TextAlign.left,),
              StreamBuilder(
                  stream: databaseReference.child('Users').child(widget.recordName).child('relay2').onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    databaseReference.child('Users').child(widget.recordName).child('relay2').once().then((DataSnapshot snapshot) {
                    });
                    return  ElevatedButton(

                      child: Text(relay2=="ON"?"OFF":"ON",style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: Colors.green,
                        // letterSpacing: 0.84,
                        fontWeight: FontWeight.w700,
                      ),),
                      onPressed: () {
                        DateTime dateTime= DateTime.now();
                        relay2=="ON"?ref.child("relay2").set("OFF"):ref.child("relay2").set("ON");
                        //ref.child("pesticideSprayer").set(dateTime.toIso8601String());
                        ref.child("waterSprinkler").set(dateTime.toIso8601String());
                        //_showNotification();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    );
                  }
              ),
//            ElevatedButton(
//
//              child: Text(relay=="ON"?"OFF":"ON",style: TextStyle(
//                fontFamily: 'SF Pro Display',
//                color: Colors.green,
//                // letterSpacing: 0.84,
//                fontWeight: FontWeight.w700,
//              ),),
//              onPressed: () {
//                _showNotificationWithDefaultSound();
//                _showNotification();
//              },
//              style: ElevatedButton.styleFrom(
//                primary: Colors.white,
//              ),
//            )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> _signOut(BuildContext context) async{
    await _firebaseAuth.signOut().then((_){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new LogInPage(title: 'Hydroponics')));
    });

  }
}