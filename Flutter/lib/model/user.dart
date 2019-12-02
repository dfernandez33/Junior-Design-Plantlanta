import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:junior_design_plantlanta/model/user_preference.dart';
import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';

import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'user.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  UserModel._();

  factory UserModel([updates(UserModelBuilder b)]) = _$UserModel;

  static Serializer<UserModel> get serializer => _$userModelSerializer;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;
  @nullable
  @BuiltValueField(wireName: 'phone')
  String get phone;
  @nullable
  @BuiltValueField(wireName: 'address')
  String get address;
  @nullable
  @BuiltValueField(wireName: 'picture')
  String get picture;
  @nullable
  @BuiltValueField(wireName: 'preferences')
  UserPreferenceModel get preferences;
  @nullable
  @BuiltValueField(wireName: 'points')
  int get points;
  @nullable
  @BuiltValueField(wireName: 'confirmed_events')
  BuiltList<String> get confirmedEvents;
  @nullable
  @BuiltValueField(wireName: 'events')
  BuiltList<String> get events;
  @nullable
  @BuiltValueField(wireName: 'transaction_history')
  BuiltList<String> get transactionHistory;
  @nullable
  @BuiltValueField(wireName: 'uuid')
  String get uuid;

  String toJson() {
    return json.encode(serializers.serializeWith(UserModel.serializer, this));
  }

  static UserModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        UserModel.serializer, jsonString);
  }
}