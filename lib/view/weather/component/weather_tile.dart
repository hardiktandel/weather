import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/strings.dart';
import '../../../model/forecast.dart';

class WeatherTile extends StatelessWidget {
  final Forecast forecast;

  const WeatherTile({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 100.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '${forecast.main?.temp?.celsius.toStringAsFixed(0)} \u00baC',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: forecast.weather![0].iconUrl,
                  fit: BoxFit.fitHeight,
                  height: 50.0,
                ),
                Expanded(
                  child: Text(
                    '${forecast.weather![0].description}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  DateFormat(Strings.timeFormat).format(forecast.dateTime!),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
