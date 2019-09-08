import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';


import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'date_time_serializer.g.dart';


abstract class Datetime implements Built<Datetime, DatetimeBuilder> {
  Datetime._();

  factory Datetime([updates(DatetimeBuilder b)]) = _$Datetime;

  @BuiltValueField(wireName: '_nanoseconds')
  int get nanoseconds;
  @BuiltValueField(wireName: '_seconds')
  int get seconds;
  String toJson() {
    return json.encode(serializers.serializeWith(Datetime.serializer, this));
  }

  static Datetime fromJson(String jsonString) {
    return serializers.deserializeWith(
        Datetime.serializer, json.decode(jsonString));
  }

  static Serializer<Datetime> get serializer => _$datetimeSerializer;
}