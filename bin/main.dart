import 'package:DartExamples/DartExamples.dart' as DartExamples;
import 'package:DartExamples/Life.dart';

Future main(List<String> arguments) async {
  List<Person> people;
  Bank bank;
  Planet myEarth = Earth(bank, people);
  print("Don't forget, you're constant moving at ${await myEarth.floatThroughSpace()} mph");
}
