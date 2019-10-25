import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:junior_design_plantlanta/serializers/seriliazers.dart';

part 'item_model.g.dart';

abstract class ItemModel implements Built<ItemModel, ItemModelBuilder> {
  ItemModel._();

  factory ItemModel([updates(ItemModelBuilder b)]) = _$ItemModel;

  static Serializer<ItemModel> get serializer => _$itemModelSerializer;

  @BuiltValueField(wireName: 'name')
  String get name;
  @BuiltValueField(wireName: 'image')
  String get imageSrc;
  @BuiltValueField(wireName: 'itemID')
  @nullable
  String get itemId;
  @BuiltValueField(wireName: 'price')
  int get price;
  @BuiltValueField(wireName: 'quantity')
  int get quantity;
  @BuiltValueField(wireName: 'description')
  String get description;

  String toJson() {
    return json.encode(serializers.serializeWith(ItemModel.serializer, this));
  }

  static ItemModel fromJson(dynamic jsonString) {
    return standardSerializers.deserializeWith(
        ItemModel.serializer, jsonString);
  }
}

