import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/helper/weather_helper.dart';
import 'package:flutter_testing_lab/weather_service/weather_service.dart';

void main() {
  group('Weather display', () {
    final service = WeatherService();
    final weatherHelper = WeatherHelper();
    test('celsiusToFahrenheit and fahrenheitToCelsius', () {
      weatherHelper.celsiusToFahrenheit(0);
      weatherHelper.fahrenheitToCelsius(32);

      expect(weatherHelper.celsiusToFahrenheit(0), 32);
      expect(weatherHelper.fahrenheitToCelsius(32), 0);
    });
    test('1️⃣ Returns valid data for known city', () async {
      final data = await service.fetchWeatherData('London');
      expect(data, isNotNull);
      expect(data!['city'], equals('London'));
      expect(data.containsKey('temperature'), true);
    });

    test('2️⃣ Returns null for Invalid City', () async {
      final data = await service.fetchWeatherData('Invalid City');
      expect(data, isNull);
    });
  });
}
