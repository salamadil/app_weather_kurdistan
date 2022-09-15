import 'package:app_weather_kurdistan/screen/Map.dart';
import 'package:app_weather_kurdistan/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatefulWidget {
  myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  int _slectindex = 0;

  void _ontap(int index) {
    setState(() {
      // print("height screen" + MediaQuery.of(context).size.height.toString());
      _slectindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _page = [
      home_page(),
      Expanded(
          child: SingleChildScrollView(
        child: MapSample(),
      ))
      //account(),
    ];

    return GetMaterialApp(
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _slectindex,
              onTap: _ontap,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_city),
                  label: "Map",
                ),
              ]),
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body: Column(
            children: [
              //
              _page[_slectindex],
              //
              // _page()
            ],
          )),
    );
  }
}
