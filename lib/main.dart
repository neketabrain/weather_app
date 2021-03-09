import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './utils/date.dart';
import './utils/ui.dart';
import './services/weather.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static final DateTime now = DateTime.now();
  static final String date = getStringifiedDate(now);

  Future<Weather> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeather('Krasnoyarsk');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            getBackgroundPath(now),
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          AppBar(
            title: Text('Krasnoyarsk'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: null,
            ),
            brightness: Brightness.dark,
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              child: Center(
                  child: FutureBuilder<Weather>(
                      future: weatherData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Text(
                                '${snapshot.data.temperature}°C',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }
}
