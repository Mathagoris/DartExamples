import 'package:DartExamples/DartExamples.dart' as DartExamples;
import 'package:DartExamples/life.dart';
import 'package:DartExamples/iss.dart';

import 'package:http/http.dart';

Future main(List<String> arguments) async {
  List<Person> people = [Person("Alice"), Person("Bob"), Person("Craig")];
  Bank bank;
  Planet myEarth = Earth(bank, people);
  print("Don't forget, you're constant moving at ${await myEarth.floatThroughSpace()} mph");

  // Find ISS current location 
  IssLocator loc = new IssLocator(new Client());
  await loc.update();
  print("Current ISS GPS coordinates: " + loc.currentPosition.toString());
}
