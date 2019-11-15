import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';
import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'activity_model.g.dart';

abstract class ActivityModel implements Built<ActivityModel, ActivityModelBuilder> {
  ActivityModel._();

  factory ActivityModel([updates(ActivityModelBuilder b)]) = _$ActivityModel;

  static Serializer<ActivityModel> get serializer => _$activityModelSerializer;

  @BuiltValueField(wireName: 'date')
  Datetime get date;
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'activityType')
  String get activityType;
  @BuiltValueField(wireName: 'userName')
  String get userName;
  @BuiltValueField(wireName: 'userId')
  String get userId;

  String toJson() {
    return json.encode(serializers.serializeWith(ActivityModel.serializer, this));
  }

  static ActivityModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        ActivityModel.serializer, jsonString);
  }
}

