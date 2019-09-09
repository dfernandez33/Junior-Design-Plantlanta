import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'user_preference.g.dart';

abstract class UserPreferenceModel implements Built<UserPreferenceModel, UserPreferenceModelBuilder> {
  UserPreferenceModel._();

  factory UserPreferenceModel([updates(UserPreferenceModelBuilder b)]) = _$UserPreferenceModel;

  static Serializer<UserPreferenceModel> get serializer => _$userPreferenceModelSerializer;

  @nullable
  @BuiltValueField(wireName: 'event_type')
  BuiltList<String> get eventType;
  @nullable
  @BuiltValueField(wireName: 'sporadic')
  bool get sporadic;
  @nullable
  @BuiltValueField(wireName: 'proximity')
  String get proximity;

  String toJson() {
    return json.encode(serializers.serializeWith(UserPreferenceModel.serializer, this));
  }

  static UserPreferenceModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        UserPreferenceModel.serializer, jsonString);
  }
}