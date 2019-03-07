import 'dart:io';
import 'dart:math';

import 'package:DartExamples/life.dart';
import 'package:DartExamples/iss.dart';

import 'package:http/http.dart';

Future main(List<String> arguments) async {
  // Find ISS current location 
  IssLocator loc = new IssLocator(new Client());
  await loc.update();
  print("Current ISS GPS coordinates: ${loc.currentPosition}");
  const Point<double> cpp = Point(34.058642, -117.824860);
  final double dist = sphericalDistanceKm(loc.currentPosition, cpp);
  print('Current ISSGPS coordinates: [lat, lon]=[${loc.currentPosition.x},${loc.currentPosition.y}]');
  print('Current distance from CPP to ISS is ${dist} km\n');

  print('Start next example...');

  while(await stdin.isEmpty){}

  List<Person> people = [Person("Alice"), Person("Bob"), Person("Craig")];
  Bank bank = Bank();
  Planet myEarth = Earth(bank, people);
  await myEarth.floatThroughSpace();
}
