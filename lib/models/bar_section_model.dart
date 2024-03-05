import 'dart:convert';

class BarSectionModel {
  final String color;
  final String meaning;
  final BarSectionRange range;
  BarSectionModel({
    required this.color,
    required this.meaning,
    required this.range,
  });

  BarSectionModel copyWith({
    String? color,
    String? meaning,
    BarSectionRange? range,
  }) {
    return BarSectionModel(
      color: color ?? this.color,
      meaning: meaning ?? this.meaning,
      range: range ?? this.range,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'color': color});
    result.addAll({'meaning': meaning});
    result.addAll({'range': range.toMap()});

    return result;
  }

  factory BarSectionModel.fromMap(Map<String, dynamic> map) {
    return BarSectionModel(
      color: map['color'] ?? '',
      meaning: map['meaning'] ?? '',
      range: BarSectionRange.fromMap(map['range']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BarSectionModel.fromJson(String source) =>
      BarSectionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'BarSectionModel(color: $color, meaning: $meaning, range: $range)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarSectionModel &&
        other.color == color &&
        other.meaning == meaning &&
        other.range == range;
  }

  @override
  int get hashCode => color.hashCode ^ meaning.hashCode ^ range.hashCode;
}

class BarSectionRange {
  final int lowerLimit;
  final int upperLimit;

  BarSectionRange({
    required this.lowerLimit,
    required this.upperLimit,
  });

  BarSectionRange copyWith({
    int? lowerLimit,
    int? upperLimit,
  }) {
    return BarSectionRange(
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'lowerLimit': lowerLimit});
    result.addAll({'upperLimit': upperLimit});

    return result;
  }

  factory BarSectionRange.fromMap(Map<String, dynamic> map) {
    return BarSectionRange(
      lowerLimit: map['lowerLimit']?.toInt() ?? 0,
      upperLimit: map['upperLimit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BarSectionRange.fromJson(String source) =>
      BarSectionRange.fromMap(json.decode(source));

  @override
  String toString() =>
      'BarSectionRange(lowerLimit: $lowerLimit, upperLimit: $upperLimit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarSectionRange &&
        other.lowerLimit == lowerLimit &&
        other.upperLimit == upperLimit;
  }

  @override
  int get hashCode => lowerLimit.hashCode ^ upperLimit.hashCode;
}
