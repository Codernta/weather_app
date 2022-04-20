import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      title: 'weather application',
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp;
  var description;
  var current;
  var humidity;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=london&units=imperial&appid=671d6406457349e080a5a82861379ec6'),
    );
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.current = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
    });
  }

  void initstate() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Current Weather Calicut",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u0000" : "Loading",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    current != null ? current.toString() : "Loading",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.thermometer,
                    ),
                    title: const Text('Temperature'),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u0000" : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.cloud,
                    ),
                    title: const Text('Weather'),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.sun,
                    ),
                    title: const Text('Humidity'),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.wind,
                    ),
                    title: const Text('wind Speed'),
                    trailing: Text(
                        windspeed != null ? windspeed.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
