// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransactionModel> _$transactionModelSerializer =
    new _$TransactionModelSerializer();

class _$TransactionModelSerializer
    implements StructuredSerializer<TransactionModel> {
  @override
  final Iterable<Type> types = const [TransactionModel, _$TransactionModel];
  @override
  final String wireName = 'TransactionModel';

  @override
  Iterable<Object> serialize(Serializers serializers, TransactionModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'timestamp',
      serializers.serialize(object.date,
          specifiedType: const FullType(Datetime)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount, specifiedType: const FullType(int)),
      'uuid',
      serializers.serialize(object.uuid, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TransactionModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'timestamp':
          result.date.replace(serializers.deserialize(value,
              specifiedType: const FullType(Datetime)) as Datetime);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uuid':
          result.uuid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionModel extends TransactionModel {
  @override
  final Datetime date;
  @override
  final String description;
  @override
  final int amount;
  @override
  final String uuid;

  factory _$TransactionModel(
          [void Function(TransactionModelBuilder) updates]) =>
      (new TransactionModelBuilder()..update(updates)).build();

  _$TransactionModel._({this.date, this.description, this.amount, this.uuid})
      : super._() {
    if (date == null) {
      throw new BuiltValueNullFieldError('TransactionModel', 'date');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('TransactionModel', 'description');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('TransactionModel', 'amount');
    }
    if (uuid == null) {
      throw new BuiltValueNullFieldError('TransactionModel', 'uuid');
    }
  }

  @override
  TransactionModel rebuild(void Function(TransactionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionModelBuilder toBuilder() =>
      new TransactionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionModel &&
        date == other.date &&
        description == other.description &&
        amount == other.amount &&
        uuid == other.uuid;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, date.hashCode), description.hashCode), amount.hashCode),
        uuid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TransactionModel')
          ..add('date', date)
          ..add('description', description)
          ..add('amount', amount)
          ..add('uuid', uuid))
        .toString();
  }
}

class TransactionModelBuilder
    implements Builder<TransactionModel, TransactionModelBuilder> {
  _$TransactionModel _$v;

  DatetimeBuilder _date;
  DatetimeBuilder get date => _$this._date ??= new DatetimeBuilder();
  set date(DatetimeBuilder date) => _$this._date = date;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  int _amount;
  int get amount => _$this._amount;
  set amount(int amount) => _$this._amount = amount;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  TransactionModelBuilder();

  TransactionModelBuilder get _$this {
    if (_$v != null) {
      _date = _$v.date?.toBuilder();
      _description = _$v.description;
      _amount = _$v.amount;
      _uuid = _$v.uuid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TransactionModel;
  }

  @override
  void update(void Function(TransactionModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TransactionModel build() {
    _$TransactionModel _$result;
    try {
      _$result = _$v ??
          new _$TransactionModel._(
              date: date.build(),
              description: description,
              amount: amount,
              uuid: uuid);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'date';
        date.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TransactionModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
