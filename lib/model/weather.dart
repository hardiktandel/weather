import '../utils/extension.dart';

class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        main: json['main'],
        description: (json['description'] as String).toTitleCase(),
        icon: json['icon'],
      );

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}
