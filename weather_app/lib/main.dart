import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var sunny;
  var currently;
  var windspeed;
  String city = "Noida";

  Future getWeather() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=80b5cde93eaf08209876458a3425b7cd");
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.sunny = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "Currently in $city",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    temp != null ? temp.toString() + "\u00B0" : "Loading",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    currently != null
                        ? currently.toString() + "\u00B0"
                        : "Loading",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    shadowColor: Colors.black,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.thermometerHalf,
                        color: Colors.blue[900],
                      ),
                      title: Text(
                        "Temperature",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading",
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud,
                          color: Colors.blue[200]),
                      title: Text(
                        "Weather",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        description != null
                            ? description.toString()
                            : "Loading",
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun,
                          color: Colors.orange[500]),
                      title: Text(
                        "Sunny",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        sunny != null ? sunny.toString() : "Loading",
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind,
                          color: Colors.blue[900]),
                      title: Text(
                        "Wind",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        windspeed != null ? windspeed.toString() : "Loading",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    onChanged: (value) {
                      city = value;
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.blue[900],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your city name'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      getWeather();
                    },
                    child: Text("Check Weather"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
