// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ItemModel> _$itemModelSerializer = new _$ItemModelSerializer();

class _$ItemModelSerializer implements StructuredSerializer<ItemModel> {
  @override
  final Iterable<Type> types = const [ItemModel, _$ItemModel];
  @override
  final String wireName = 'ItemModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ItemModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.imageSrc,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price, specifiedType: const FullType(int)),
      'quantity',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(int)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    if (object.itemId != null) {
      result
        ..add('itemID')
        ..add(serializers.serialize(object.itemId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ItemModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.imageSrc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'itemID':
          result.itemId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ItemModel extends ItemModel {
  @override
  final String name;
  @override
  final String imageSrc;
  @override
  final String itemId;
  @override
  final int price;
  @override
  final int quantity;
  @override
  final String description;

  factory _$ItemModel([void Function(ItemModelBuilder) updates]) =>
      (new ItemModelBuilder()..update(updates)).build();

  _$ItemModel._(
      {this.name,
      this.imageSrc,
      this.itemId,
      this.price,
      this.quantity,
      this.description})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ItemModel', 'name');
    }
    if (imageSrc == null) {
      throw new BuiltValueNullFieldError('ItemModel', 'imageSrc');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('ItemModel', 'price');
    }
    if (quantity == null) {
      throw new BuiltValueNullFieldError('ItemModel', 'quantity');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ItemModel', 'description');
    }
  }

  @override
  ItemModel rebuild(void Function(ItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemModelBuilder toBuilder() => new ItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ItemModel &&
        name == other.name &&
        imageSrc == other.imageSrc &&
        itemId == other.itemId &&
        price == other.price &&
        quantity == other.quantity &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, name.hashCode), imageSrc.hashCode),
                    itemId.hashCode),
                price.hashCode),
            quantity.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ItemModel')
          ..add('name', name)
          ..add('imageSrc', imageSrc)
          ..add('itemId', itemId)
          ..add('price', price)
          ..add('quantity', quantity)
          ..add('description', description))
        .toString();
  }
}

class ItemModelBuilder implements Builder<ItemModel, ItemModelBuilder> {
  _$ItemModel _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _imageSrc;
  String get imageSrc => _$this._imageSrc;
  set imageSrc(String imageSrc) => _$this._imageSrc = imageSrc;

  String _itemId;
  String get itemId => _$this._itemId;
  set itemId(String itemId) => _$this._itemId = itemId;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  int _quantity;
  int get quantity => _$this._quantity;
  set quantity(int quantity) => _$this._quantity = quantity;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  ItemModelBuilder();

  ItemModelBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _imageSrc = _$v.imageSrc;
      _itemId = _$v.itemId;
      _price = _$v.price;
      _quantity = _$v.quantity;
      _description = _$v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ItemModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ItemModel;
  }

  @override
  void update(void Function(ItemModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ItemModel build() {
    final _$result = _$v ??
        new _$ItemModel._(
            name: name,
            imageSrc: imageSrc,
            itemId: itemId,
            price: price,
            quantity: quantity,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
