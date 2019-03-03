import 'dart:math';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:DartExamples/iss.dart';

// The Mock class uses noSuchMethod to catch all method invocations.
class MockIssLocator extends Mock implements IssLocator {}

void main() {
  // Given two predefined points on earth,
  // verify the calculated distance between them.
  group('Spherical distance', () {
    test('Los Angeles - CPP should be 39.18km +/- 0.1km', () {
      Point<double> la = new Point(34.0499998, -118.249999);
      Point<double> cpp = new Point(34.058642, -117.824860);
      double dist = sphericalDistanceKm(la, cpp);
      
      expect(dist, closeTo(39.18, 0.1));
    });
  });

  // Stubs IssLocator.currentPosition() using when().thenReturn().
  // Calling currentPosition() then returns the predefined location
  // for the space station.
  // Evaluate whether the space station is visible from a
  // second predefined location. This test runs asynchronously.
  group('ISS spotter', () {
    test('ISS visible', () async {
      Point<double> la = new Point(34.0499998, -118.249999);
      Point<double> cpp = new Point(34.058642, -117.824860);
      IssLocator locator = new MockIssLocator();
      // CPP should be visible from Los Angeles.
      when(locator.currentPosition).thenReturn(la);

      var spotter = new IssSpotter(locator, cpp);
      expect(spotter.isVisible, true);
    });

    test('ISS not visible', () async {
      Point<double> london = new Point(51.5073, -0.1277);
      Point<double> cpp = new Point(34.058642, -117.824860);
      IssLocator locator = new MockIssLocator();
      // CPP should not be visible from Mountain View.
      when(locator.currentPosition).thenReturn(london);

      var spotter = new IssSpotter(locator, cpp);
      expect(spotter.isVisible, false);
    });
  });
}