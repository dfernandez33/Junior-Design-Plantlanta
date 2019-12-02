import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';
import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'friend_request_model.g.dart';

abstract class FriendRequestModel implements Built<FriendRequestModel, FriendRequestModelBuilder> {
  FriendRequestModel._();

  factory FriendRequestModel([updates(FriendRequestModelBuilder b)]) = _$FriendRequestModel;

  static Serializer<FriendRequestModel> get serializer => _$friendRequestModelSerializer;

  @BuiltValueField(wireName: 'sender')
  String get sender;
  @BuiltValueField(wireName: 'receiver')
  String get receiver;

  String toJson() {
    return json.encode(serializers.serializeWith(FriendRequestModel.serializer, this));
  }

  static FriendRequestModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        FriendRequestModel.serializer, jsonString);
  }
}

