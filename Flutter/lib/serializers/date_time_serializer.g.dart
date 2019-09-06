// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_serializer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Datetime> _$datetimeSerializer = new _$DatetimeSerializer();

class _$DatetimeSerializer implements StructuredSerializer<Datetime> {
  @override
  final Iterable<Type> types = const [Datetime, _$Datetime];
  @override
  final String wireName = 'Datetime';

  @override
  Iterable<Object> serialize(Serializers serializers, Datetime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      '_nanoseconds',
      serializers.serialize(object.nanoseconds,
          specifiedType: const FullType(int)),
      '_seconds',
      serializers.serialize(object.seconds, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Datetime deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case '_nanoseconds':
          result.nanoseconds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '_seconds':
          result.seconds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Datetime extends Datetime {
  @override
  final int nanoseconds;
  @override
  final int seconds;

  factory _$Datetime([void Function(DatetimeBuilder) updates]) =>
      (new DatetimeBuilder()..update(updates)).build();

  _$Datetime._({this.nanoseconds, this.seconds}) : super._() {
    if (nanoseconds == null) {
      throw new BuiltValueNullFieldError('Datetime', 'nanoseconds');
    }
    if (seconds == null) {
      throw new BuiltValueNullFieldError('Datetime', 'seconds');
    }
  }

  @override
  Datetime rebuild(void Function(DatetimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeBuilder toBuilder() => new DatetimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Datetime &&
        nanoseconds == other.nanoseconds &&
        seconds == other.seconds;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, nanoseconds.hashCode), seconds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Datetime')
          ..add('nanoseconds', nanoseconds)
          ..add('seconds', seconds))
        .toString();
  }
}

class DatetimeBuilder implements Builder<Datetime, DatetimeBuilder> {
  _$Datetime _$v;

  int _nanoseconds;
  int get nanoseconds => _$this._nanoseconds;
  set nanoseconds(int nanoseconds) => _$this._nanoseconds = nanoseconds;

  int _seconds;
  int get seconds => _$this._seconds;
  set seconds(int seconds) => _$this._seconds = seconds;

  DatetimeBuilder();

  DatetimeBuilder get _$this {
    if (_$v != null) {
      _nanoseconds = _$v.nanoseconds;
      _seconds = _$v.seconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Datetime other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Datetime;
  }

  @override
  void update(void Function(DatetimeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Datetime build() {
    final _$result =
        _$v ?? new _$Datetime._(nanoseconds: nanoseconds, seconds: seconds);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
