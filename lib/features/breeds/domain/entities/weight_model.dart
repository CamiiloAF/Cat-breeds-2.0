import '../../../../core/entities/entity_model.dart';

class Weight extends ModelEntity {
  Weight({
    required this.imperial,
    required this.metric,
  });

  factory Weight.fromJson(final Map<String, dynamic> json) => Weight(
        imperial: json['imperial'],
        metric: json['metric'],
      );

  final String imperial;
  final String metric;

  @override
  Weight fromJson(final Map<String, dynamic> source) => Weight.fromJson(source);

  @override
  Map<String, dynamic> toJson() => {
        'imperial': imperial,
        'metric': metric,
      };
}
