import '../utils/utils.dart';
import 'temperature.dart';
import 'weather.dart';

class Forecast {
  final int? dt;
  final Main? main;
  final List<Weather>? weather;
  final Cloud? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Rain? rain;
  final Sys? sys;
  final String? dtTxt;
  final DateTime? date;
  final DateTime? dateTime;

  Forecast({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
    this.date,
    this.dateTime,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    return Forecast(
      dt: json['dt'],
      main: json['main'] == null ? null : Main.fromJson(json['main']),
      weather: json['weather'] == null
          ? []
          : List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      clouds: json['clouds'] == null ? null : Cloud.fromJson(json['clouds']),
      wind: json['wind'] == null ? null : Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: getDoubleValue(json['pop']),
      rain: json['rain'] == null ? null : Rain.fromJson(json['rain']),
      sys: json['sys'] == null ? null : Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
      dateTime: dateTime,
      date: DateTime(dateTime.year, dateTime.month, dateTime.day),
    );
  }
}

class Main {
  final Temperature? temp;
  final Temperature? feelsLike;
  final Temperature? tempMin;
  final Temperature? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final Temperature? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: Temperature.kelvin(getDoubleValue(json['temp'])),
        feelsLike: Temperature.kelvin(getDoubleValue(json['feels_like'])),
        tempMin: Temperature.kelvin(getDoubleValue(json['temp_min'])),
        tempMax: Temperature.kelvin(getDoubleValue(json['temp_max'])),
        pressure: json['pressure'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        humidity: json['humidity'],
        tempKf: Temperature.kelvin(getDoubleValue(json['temp_kf'])),
      );
}

class Cloud {
  final int? all;

  Cloud({
    this.all,
  });

  factory Cloud.fromJson(Map<String, dynamic> json) => Cloud(
        all: json['all'],
      );
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: getDoubleValue(json['speed']),
        deg: json['deg'],
        gust: getDoubleValue(json['gust']),
      );
}

class Rain {
  final double? $3h;

  Rain({
    this.$3h,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        $3h: getDoubleValue(json['3h']),
      );
}

class Sys {
  final String? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod'],
      );
}
