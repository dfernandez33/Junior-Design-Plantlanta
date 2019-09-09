// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserPreferenceModel> _$userPreferenceModelSerializer =
    new _$UserPreferenceModelSerializer();

class _$UserPreferenceModelSerializer
    implements StructuredSerializer<UserPreferenceModel> {
  @override
  final Iterable<Type> types = const [
    UserPreferenceModel,
    _$UserPreferenceModel
  ];
  @override
  final String wireName = 'UserPreferenceModel';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UserPreferenceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.eventType != null) {
      result
        ..add('event_type')
        ..add(serializers.serialize(object.eventType,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.sporadic != null) {
      result
        ..add('sporadic')
        ..add(serializers.serialize(object.sporadic,
            specifiedType: const FullType(bool)));
    }
    if (object.proximity != null) {
      result
        ..add('proximity')
        ..add(serializers.serialize(object.proximity,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserPreferenceModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserPreferenceModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'event_type':
          result.eventType.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'sporadic':
          result.sporadic = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'proximity':
          result.proximity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserPreferenceModel extends UserPreferenceModel {
  @override
  final BuiltList<String> eventType;
  @override
  final bool sporadic;
  @override
  final String proximity;

  factory _$UserPreferenceModel(
          [void Function(UserPreferenceModelBuilder) updates]) =>
      (new UserPreferenceModelBuilder()..update(updates)).build();

  _$UserPreferenceModel._({this.eventType, this.sporadic, this.proximity})
      : super._();

  @override
  UserPreferenceModel rebuild(
          void Function(UserPreferenceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPreferenceModelBuilder toBuilder() =>
      new UserPreferenceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPreferenceModel &&
        eventType == other.eventType &&
        sporadic == other.sporadic &&
        proximity == other.proximity;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, eventType.hashCode), sporadic.hashCode),
        proximity.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserPreferenceModel')
          ..add('eventType', eventType)
          ..add('sporadic', sporadic)
          ..add('proximity', proximity))
        .toString();
  }
}

class UserPreferenceModelBuilder
    implements Builder<UserPreferenceModel, UserPreferenceModelBuilder> {
  _$UserPreferenceModel _$v;

  ListBuilder<String> _eventType;
  ListBuilder<String> get eventType =>
      _$this._eventType ??= new ListBuilder<String>();
  set eventType(ListBuilder<String> eventType) => _$this._eventType = eventType;

  bool _sporadic;
  bool get sporadic => _$this._sporadic;
  set sporadic(bool sporadic) => _$this._sporadic = sporadic;

  String _proximity;
  String get proximity => _$this._proximity;
  set proximity(String proximity) => _$this._proximity = proximity;

  UserPreferenceModelBuilder();

  UserPreferenceModelBuilder get _$this {
    if (_$v != null) {
      _eventType = _$v.eventType?.toBuilder();
      _sporadic = _$v.sporadic;
      _proximity = _$v.proximity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPreferenceModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserPreferenceModel;
  }

  @override
  void update(void Function(UserPreferenceModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserPreferenceModel build() {
    _$UserPreferenceModel _$result;
    try {
      _$result = _$v ??
          new _$UserPreferenceModel._(
              eventType: _eventType?.build(),
              sporadic: sporadic,
              proximity: proximity);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'eventType';
        _eventType?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserPreferenceModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
