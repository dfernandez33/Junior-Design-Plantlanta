import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';
import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'transaction_model.g.dart';

abstract class TransactionModel implements Built<TransactionModel, TransactionModelBuilder> {
  TransactionModel._();

  factory TransactionModel([updates(TransactionModelBuilder b)]) = _$TransactionModel;

  static Serializer<TransactionModel> get serializer => _$transactionModelSerializer;

  @BuiltValueField(wireName: 'timestamp')
  Datetime get date;
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'amount')
  int get amount;
  @BuiltValueField(wireName: 'uuid')
  String get uuid;

  String toJson() {
    return json.encode(serializers.serializeWith(TransactionModel.serializer, this));
  }

  static TransactionModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        TransactionModel.serializer, jsonString);
  }
}

