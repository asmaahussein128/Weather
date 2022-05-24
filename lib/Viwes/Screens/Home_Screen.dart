import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:weatherasmaa/Models/Temp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String weather = "clear";
  var abbr =
      "c";
  int temp = 0;
  String location = "city";
  var weoid = 0;

  Future<void> fetchcity(var location1) async {
    var urL = Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=${location1}');

    var response = await http.get(urL);
    var responsebody = jsonDecode(response.body)[0];
    setState(() {
      location = responsebody["title"];
      weoid = responsebody["woeid"];
    });
  }

  Future<void> fetchweoid() async {
    var urL = Uri.parse("https://www.metaweather.com/api/location/$weoid/");
    var response = await http.get(urL);
    var responsebody = jsonDecode(response.body)["consolidated_weather"][0];
    setState(() {
      weather =
          responsebody["weather_state_name"].replaceAll(" ", "").toLowerCase();
      abbr = responsebody["weather_state_abbr"];
      //getasmaa();
      temp = responsebody["the_temp"].round();
    });
  }

  Future<List<Temp>> fetchlist() async {
    List<Temp> asmaa = [];
    var urL = Uri.parse("https://www.metaweather.com/api/location/$weoid/");
    var response = await http.get(urL);
    var responsebody = jsonDecode(response.body)["consolidated_weather"];
    for (var index in responsebody) {
      Temp x = Temp(
          min_temp: index["min_temp"],
          max_temp: index["max_temp"],
          applicable_date: index["applicable_date"],
          weather_state_abbr: index["weather_state_abbr"]);
      asmaa.add(x);
    }
    return asmaa;
  }

  Future<void> get(String location2) async {
    await fetchcity(location2);
    await fetchweoid();
  }

  dynamic getasmaa1() {
    double hB=110;
    if (abbr == "sn") {
      return Lottie.asset('lib/images/64966-snow-icon.json',
          width: hB, height: hB);
    } else if (abbr == "sl") {
      return Image.network(
        "https://www.metaweather.com/static/img/weather/png/${abbr}.png",
        height: hB,
        width: hB,
      ); //Lottie.asset('', width: hB, height: hB);
    } else if (abbr == "h") {
      return Lottie.asset('lib/images/50667-hail.json',
          width: hB, height: hB);
    } else if (abbr == "hr") {
      return Lottie.asset('lib/images/67989-wind-and-rain.json',
          width: hB, height: hB);
    } else if (abbr == "c") {
      return Lottie.asset('lib/images/82378-sunny-weather.json',
          width: hB, height: hB);
    } else if (abbr == "s") {
      return Lottie.asset('lib/images/4792-weather-stormshowersday.json',
          width: hB, height: hB);
    } else if (abbr == "hc") {
      return Lottie.asset('lib/images/4396-clouds.json',
          width: hB, height: hB);
    } else if (abbr == "lr") {
      return
      Lottie.asset('lib/images/50654-light-rain.json',
      width: hB, height: hB);
    } else {
      return Lottie.asset('lib/images/81424-light-mode.json',
          width: hB, height: hB);
    }
  }

  dynamic getasmaa2(String abber1) {
    double  hS=70;
    if (abber1 == "sn") {
      return Lottie.asset('lib/images/64966-snow-icon.json',
          width: hS, height: hS);
    } else if (abber1 == "sl") {
      return Image.network(
        "https://www.metaweather.com/static/img/weather/png/${abber1}.png",
        height: hS,
        width: hS,
      ); //Lottie.asset('', width: hS, height: hS);
    } else if (abber1 == "h") {
      return Lottie.asset('lib/images/50667-hail.json', width: hS, height: hS);
    } else if (abber1 == "hr") {
      return Lottie.asset('lib/images/67989-wind-and-rain.json',
          width: hS, height: hS);
    } else if (abber1 == "c") {
      return Lottie.asset('lib/images/82378-sunny-weather.json',
          width: hS, height: hS);
    } else if (abber1 == "s") {
      return Lottie.asset('lib/images/4792-weather-stormshowersday.json',
          width: hS, height: hS);
    } else if (abber1 == "hc") {
      return
      Lottie.asset('lib/images/4396-clouds.json', width: hS, height: hS);
    } else if (abber1 == "lr") {
      return Lottie.asset('lib/images/50654-light-rain.json',
          width: hS, height: hS);
    } else {
      return Lottie.asset('lib/images/81424-light-mode.json',
          width: hS, height: hS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "lib/images/${weather}.png",
                ),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: (abbr == "sl" )
                              ? Image.network(
                                  "https://www.metaweather.com/static/img/weather/png/${abbr}.png",
                                  height: 100,
                                  width: 100,
                                )
                              : getasmaa1()),
                      Text(
                        "$temp C",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40),
                      ),
                      Text(
                        "$location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onChanged: (String input) {
                            setState(() {
                              print(input);
                              get(input);
                            });
                          },
                          style: TextStyle(fontSize: 24, color: Colors.white),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                              ),
                              hintText: "Search About City...",
                              hintStyle:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 220,
                            child: FutureBuilder(
                              future: fetchlist(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          child: Container(
                                            height: 220,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Date: ${snapshot.data[index].applicable_date}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  (snapshot.data[index]
                                                                  .weather_state_abbr ==
                                                              "sl")
                                                      ? Image.network(
                                                          "https://www.metaweather.com/static/img/weather/png/${snapshot.data[index].weather_state_abbr}.png",
                                                          height: 40,
                                                          width: 40,
                                                        )
                                                      : getasmaa2(
                                                          "${snapshot.data[index].weather_state_abbr}"),
                                                  Text(
                                                    "$location",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Max : ${snapshot.data[index].max_temp.round()}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Min : ${snapshot.data[index].min_temp.round()}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        );
                                      });
                                } else {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Enter City...",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.teal),
                                      ));
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }
}
