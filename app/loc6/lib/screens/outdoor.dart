import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Outdoor extends StatefulWidget {
  const Outdoor({super.key});

  @override
  State<Outdoor> createState() => _OutdoorState();
}

class _OutdoorState extends State<Outdoor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 60,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Locate",
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 34.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => MapsLauncher.launchQuery(
                    'Railway Station with wheel chairs'),
                child: Card(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.wheelchair_pickup, size: 60),
                        title: Text('Railway Station',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        subtitle: Text('With Wheel Chair'),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () => MapsLauncher.launchQuery(
                    'Closest Police Station near me'),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.local_police, size: 60),
                        title: Text('Police Station',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        subtitle: Text('For reporting crimes and emergencies'),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () => MapsLauncher.launchQuery('Closest Hospital'),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.local_hospital, size: 50),
                        title: Text('Hospital',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        subtitle: Text('For medical emergencies and treatment'),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(20.0),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () => MapsLauncher.launchCoordinates(
              //       19.16589609074014, 73.00022139611664, 'Restaurant is here'),
              //   child: Card(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: const <Widget>[
              //         ListTile(
              //           leading: Icon(Icons.sign_language_sharp, size: 40),
              //           title: Text('Restaurants',
              //               style: TextStyle(
              //                   fontSize: 24,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black)),
              //           subtitle: Text('Restaurant with sign language'),
              //         ),
              //       ],
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     color: Colors.white,
              //     margin: EdgeInsets.all(20.0),
              //   ),
              // ),
              ElevatedButton(
                onPressed: () => MapsLauncher.launchQuery(
                    //19.107487308585704, 72.83733383928633,
                    'SVKMs Dwarkadas J. Sanghvi College of Engineering '),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.location_city, size: 50),
                        title: Text('Locate Me',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        subtitle: Text('Current Location'),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
