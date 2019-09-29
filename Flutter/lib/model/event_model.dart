import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';
import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'event_model.g.dart';

abstract class EventModel implements Built<EventModel, EventModelBuilder> {
  EventModel._();

  factory EventModel([updates(EventModelBuilder b)]) = _$EventModel;

  static Serializer<EventModel> get serializer => _$eventModelSerializer;

  @BuiltValueField(wireName: 'date')
  Datetime get date;
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'location')
  String get location;
  @BuiltValueField(wireName: 'participants')
  BuiltList<String> get participants;
  @BuiltValueField(wireName: 'name')
  String get name;
  @BuiltValueField(wireName: 'eventId')
  String get eventId;
  @BuiltValueField(wireName: 'startTime')
  String get startTime;
  @BuiltValueField(wireName: 'endTime')
  String get endTime;

  String toJson() {
    return json.encode(serializers.serializeWith(EventModel.serializer, this));
  }

  static EventModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        EventModel.serializer, jsonString);
  }
}

