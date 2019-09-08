// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EventModel> _$eventModelSerializer = new _$EventModelSerializer();

class _$EventModelSerializer implements StructuredSerializer<EventModel> {
  @override
  final Iterable<Type> types = const [EventModel, _$EventModel];
  @override
  final String wireName = 'EventModel';

  @override
  Iterable<Object> serialize(Serializers serializers, EventModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'datetime',
      serializers.serialize(object.datetime,
          specifiedType: const FullType(Datetime)),
      'Description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'Location',
      serializers.serialize(object.location,
          specifiedType: const FullType(String)),
      'participants',
      serializers.serialize(object.participants,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'Name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'eventId',
      serializers.serialize(object.eventId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  EventModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EventModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'datetime':
          result.datetime.replace(serializers.deserialize(value,
              specifiedType: const FullType(Datetime)) as Datetime);
          break;
        case 'Description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'participants':
          result.participants.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'Name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventId':
          result.eventId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$EventModel extends EventModel {
  @override
  final Datetime datetime;
  @override
  final String description;
  @override
  final String location;
  @override
  final BuiltList<String> participants;
  @override
  final String name;
  @override
  final String eventId;

  factory _$EventModel([void Function(EventModelBuilder) updates]) =>
      (new EventModelBuilder()..update(updates)).build();

  _$EventModel._(
      {this.datetime,
      this.description,
      this.location,
      this.participants,
      this.name,
      this.eventId})
      : super._() {
    if (datetime == null) {
      throw new BuiltValueNullFieldError('EventModel', 'datetime');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('EventModel', 'description');
    }
    if (location == null) {
      throw new BuiltValueNullFieldError('EventModel', 'location');
    }
    if (participants == null) {
      throw new BuiltValueNullFieldError('EventModel', 'participants');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('EventModel', 'name');
    }
    if (eventId == null) {
      throw new BuiltValueNullFieldError('EventModel', 'eventId');
    }
  }

  @override
  EventModel rebuild(void Function(EventModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventModelBuilder toBuilder() => new EventModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventModel &&
        datetime == other.datetime &&
        description == other.description &&
        location == other.location &&
        participants == other.participants &&
        name == other.name &&
        eventId == other.eventId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, datetime.hashCode), description.hashCode),
                    location.hashCode),
                participants.hashCode),
            name.hashCode),
        eventId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EventModel')
          ..add('datetime', datetime)
          ..add('description', description)
          ..add('location', location)
          ..add('participants', participants)
          ..add('name', name)
          ..add('eventId', eventId))
        .toString();
  }
}

class EventModelBuilder implements Builder<EventModel, EventModelBuilder> {
  _$EventModel _$v;

  DatetimeBuilder _datetime;
  DatetimeBuilder get datetime => _$this._datetime ??= new DatetimeBuilder();
  set datetime(DatetimeBuilder datetime) => _$this._datetime = datetime;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  ListBuilder<String> _participants;
  ListBuilder<String> get participants =>
      _$this._participants ??= new ListBuilder<String>();
  set participants(ListBuilder<String> participants) =>
      _$this._participants = participants;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _eventId;
  String get eventId => _$this._eventId;
  set eventId(String eventId) => _$this._eventId = eventId;

  EventModelBuilder();

  EventModelBuilder get _$this {
    if (_$v != null) {
      _datetime = _$v.datetime?.toBuilder();
      _description = _$v.description;
      _location = _$v.location;
      _participants = _$v.participants?.toBuilder();
      _name = _$v.name;
      _eventId = _$v.eventId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EventModel;
  }

  @override
  void update(void Function(EventModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EventModel build() {
    _$EventModel _$result;
    try {
      _$result = _$v ??
          new _$EventModel._(
              datetime: datetime.build(),
              description: description,
              location: location,
              participants: participants.build(),
              name: name,
              eventId: eventId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'datetime';
        datetime.build();

        _$failedField = 'participants';
        participants.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EventModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
