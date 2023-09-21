double getDoubleValue(dynamic value) => switch (value) {
      (double d) => d,
      (int i) => i.toDouble(),
      (String s) when s.isNotEmpty => double.parse(value),
      _ => 0.0,
    };
