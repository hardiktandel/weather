import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/strings.dart';
import '../../../model/forecast.dart';
import '../../../utils/gaps.dart';
import 'weather_tile.dart';

class DayTile extends StatelessWidget {
  final DateTime today;
  final DateTime date;
  final List<Forecast>? forecasts;

  const DayTile({
    super.key,
    required this.today,
    required this.date,
    this.forecasts,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              date.isAtSameMomentAs(today)
                  ? '${Strings.today} - ${DateFormat(Strings.dateFormat).format(date)}'
                  : DateFormat(Strings.dateFormat).format(date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 150.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: forecasts!.length,
              separatorBuilder: (context, index) => gapW10,
              itemBuilder: (context, index) =>
                  WeatherTile(forecast: forecasts![index]),
            ),
          ),
        ],
      );
}
