// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ActivityModel> _$activityModelSerializer =
    new _$ActivityModelSerializer();

class _$ActivityModelSerializer implements StructuredSerializer<ActivityModel> {
  @override
  final Iterable<Type> types = const [ActivityModel, _$ActivityModel];
  @override
  final String wireName = 'ActivityModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ActivityModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'timestamp',
      serializers.serialize(object.date,
          specifiedType: const FullType(Datetime)),
      'activitytype',
      serializers.serialize(object.activityType,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.userName,
          specifiedType: const FullType(String)),
      'uuid',
      serializers.serialize(object.uuid, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ActivityModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ActivityModelBuilder();

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
        case 'activitytype':
          result.activityType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$ActivityModel extends ActivityModel {
  @override
  final Datetime date;
  @override
  final String activityType;
  @override
  final String description;
  @override
  final String userName;
  @override
  final String uuid;

  factory _$ActivityModel([void Function(ActivityModelBuilder) updates]) =>
      (new ActivityModelBuilder()..update(updates)).build();

  _$ActivityModel._(
      {this.date,
      this.activityType,
      this.description,
      this.userName,
      this.uuid})
      : super._() {
    if (date == null) {
      throw new BuiltValueNullFieldError('ActivityModel', 'date');
    }
    if (activityType == null) {
      throw new BuiltValueNullFieldError('ActivityModel', 'activityType');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ActivityModel', 'description');
    }
    if (userName == null) {
      throw new BuiltValueNullFieldError('ActivityModel', 'userName');
    }
    if (uuid == null) {
      throw new BuiltValueNullFieldError('ActivityModel', 'uuid');
    }
  }

  @override
  ActivityModel rebuild(void Function(ActivityModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityModelBuilder toBuilder() => new ActivityModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityModel &&
        date == other.date &&
        activityType == other.activityType &&
        description == other.description &&
        userName == other.userName &&
        uuid == other.uuid;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, date.hashCode), activityType.hashCode),
                description.hashCode),
            userName.hashCode),
        uuid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ActivityModel')
          ..add('date', date)
          ..add('activityType', activityType)
          ..add('description', description)
          ..add('userName', userName)
          ..add('uuid', uuid))
        .toString();
  }
}

class ActivityModelBuilder
    implements Builder<ActivityModel, ActivityModelBuilder> {
  _$ActivityModel _$v;

  DatetimeBuilder _date;
  DatetimeBuilder get date => _$this._date ??= new DatetimeBuilder();
  set date(DatetimeBuilder date) => _$this._date = date;

  String _activityType;
  String get activityType => _$this._activityType;
  set activityType(String activityType) => _$this._activityType = activityType;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  ActivityModelBuilder();

  ActivityModelBuilder get _$this {
    if (_$v != null) {
      _date = _$v.date?.toBuilder();
      _activityType = _$v.activityType;
      _description = _$v.description;
      _userName = _$v.userName;
      _uuid = _$v.uuid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ActivityModel;
  }

  @override
  void update(void Function(ActivityModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ActivityModel build() {
    _$ActivityModel _$result;
    try {
      _$result = _$v ??
          new _$ActivityModel._(
              date: date.build(),
              activityType: activityType,
              description: description,
              userName: userName,
              uuid: uuid);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'date';
        date.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ActivityModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
