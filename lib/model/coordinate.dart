class Coordinate {
  final double lat;
  final double lon;

  Coordinate({required this.lat, required this.lon});

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json['lat'],
        lon: json['lon'],
      );
}
