import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/seriliazers.dart';
import 'package:junior_design_plantlanta/model/user_preference.dart';

part 'registration_model.g.dart';

abstract class UserRegistrationModel implements Built<UserRegistrationModel, UserRegistrationModelBuilder> {
  UserRegistrationModel._();

  factory UserRegistrationModel([updates(UserRegistrationModelBuilder b)]) = _$UserRegistrationModel;

  static Serializer<UserRegistrationModel> get serializer => _$userRegistrationModelSerializer;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;
  @nullable
  @BuiltValueField(wireName: 'email')
  String get email;
  @nullable
  @BuiltValueField(wireName: 'password')
  String get password;
  @nullable
  @BuiltValueField(wireName: 'dob')
  String get dob;
  @nullable
  @BuiltValueField(wireName: 'phone')
  String get phone;
  @nullable
  @BuiltValueField(wireName: 'address')
  String get address;
  @nullable
  @BuiltValueField(wireName: 'profileUrl')
  String get profileUrl;
  @nullable
  @BuiltValueField(wireName: 'preference')
  UserPreferenceModel get preference;

  String toJson() {
    return json.encode(serializers.serializeWith(UserRegistrationModel.serializer, this));
  }

  static UserRegistrationModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        UserRegistrationModel.serializer, jsonString);
  }
}