// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserModel> _$userModelSerializer = new _$UserModelSerializer();

class _$UserModelSerializer implements StructuredSerializer<UserModel> {
  @override
  final Iterable<Type> types = const [UserModel, _$UserModel];
  @override
  final String wireName = 'UserModel';

  @override
  Iterable<Object> serialize(Serializers serializers, UserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.address != null) {
      result
        ..add('address')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(String)));
    }
    if (object.picture != null) {
      result
        ..add('picture')
        ..add(serializers.serialize(object.picture,
            specifiedType: const FullType(String)));
    }
    if (object.preferences != null) {
      result
        ..add('preferences')
        ..add(serializers.serialize(object.preferences,
            specifiedType: const FullType(UserPreferenceModel)));
    }
    if (object.points != null) {
      result
        ..add('points')
        ..add(serializers.serialize(object.points,
            specifiedType: const FullType(int)));
    }
    if (object.confirmedEvents != null) {
      result
        ..add('confirmed_events')
        ..add(serializers.serialize(object.confirmedEvents,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.events != null) {
      result
        ..add('events')
        ..add(serializers.serialize(object.events,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.transactionHistory != null) {
      result
        ..add('transaction_history')
        ..add(serializers.serialize(object.transactionHistory,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.uuid != null) {
      result
        ..add('uuid')
        ..add(serializers.serialize(object.uuid,
            specifiedType: const FullType(String)));
    }
    if (object.friends != null) {
      result
        ..add('friends')
        ..add(serializers.serialize(object.friends,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  UserModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserModelBuilder();

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
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'picture':
          result.picture = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'preferences':
          result.preferences.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserPreferenceModel))
              as UserPreferenceModel);
          break;
        case 'points':
          result.points = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'confirmed_events':
          result.confirmedEvents.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'events':
          result.events.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'transaction_history':
          result.transactionHistory.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'uuid':
          result.uuid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friends':
          result.friends.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$UserModel extends UserModel {
  @override
  final String name;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String picture;
  @override
  final UserPreferenceModel preferences;
  @override
  final int points;
  @override
  final BuiltList<String> confirmedEvents;
  @override
  final BuiltList<String> events;
  @override
  final BuiltList<String> transactionHistory;
  @override
  final String uuid;
  @override
  final BuiltList<String> friends;

  factory _$UserModel([void Function(UserModelBuilder) updates]) =>
      (new UserModelBuilder()..update(updates)).build();

  _$UserModel._(
      {this.name,
      this.phone,
      this.address,
      this.picture,
      this.preferences,
      this.points,
      this.confirmedEvents,
      this.events,
      this.transactionHistory,
      this.uuid,
      this.friends})
      : super._();

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        name == other.name &&
        phone == other.phone &&
        address == other.address &&
        picture == other.picture &&
        preferences == other.preferences &&
        points == other.points &&
        confirmedEvents == other.confirmedEvents &&
        events == other.events &&
        transactionHistory == other.transactionHistory &&
        uuid == other.uuid &&
        friends == other.friends;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, name.hashCode),
                                            phone.hashCode),
                                        address.hashCode),
                                    picture.hashCode),
                                preferences.hashCode),
                            points.hashCode),
                        confirmedEvents.hashCode),
                    events.hashCode),
                transactionHistory.hashCode),
            uuid.hashCode),
        friends.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserModel')
          ..add('name', name)
          ..add('phone', phone)
          ..add('address', address)
          ..add('picture', picture)
          ..add('preferences', preferences)
          ..add('points', points)
          ..add('confirmedEvents', confirmedEvents)
          ..add('events', events)
          ..add('transactionHistory', transactionHistory)
          ..add('uuid', uuid)
          ..add('friends', friends))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _picture;
  String get picture => _$this._picture;
  set picture(String picture) => _$this._picture = picture;

  UserPreferenceModelBuilder _preferences;
  UserPreferenceModelBuilder get preferences =>
      _$this._preferences ??= new UserPreferenceModelBuilder();
  set preferences(UserPreferenceModelBuilder preferences) =>
      _$this._preferences = preferences;

  int _points;
  int get points => _$this._points;
  set points(int points) => _$this._points = points;

  ListBuilder<String> _confirmedEvents;
  ListBuilder<String> get confirmedEvents =>
      _$this._confirmedEvents ??= new ListBuilder<String>();
  set confirmedEvents(ListBuilder<String> confirmedEvents) =>
      _$this._confirmedEvents = confirmedEvents;

  ListBuilder<String> _events;
  ListBuilder<String> get events =>
      _$this._events ??= new ListBuilder<String>();
  set events(ListBuilder<String> events) => _$this._events = events;

  ListBuilder<String> _transactionHistory;
  ListBuilder<String> get transactionHistory =>
      _$this._transactionHistory ??= new ListBuilder<String>();
  set transactionHistory(ListBuilder<String> transactionHistory) =>
      _$this._transactionHistory = transactionHistory;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  ListBuilder<String> _friends;
  ListBuilder<String> get friends =>
      _$this._friends ??= new ListBuilder<String>();
  set friends(ListBuilder<String> friends) => _$this._friends = friends;

  UserModelBuilder();

  UserModelBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _phone = _$v.phone;
      _address = _$v.address;
      _picture = _$v.picture;
      _preferences = _$v.preferences?.toBuilder();
      _points = _$v.points;
      _confirmedEvents = _$v.confirmedEvents?.toBuilder();
      _events = _$v.events?.toBuilder();
      _transactionHistory = _$v.transactionHistory?.toBuilder();
      _uuid = _$v.uuid;
      _friends = _$v.friends?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserModel build() {
    _$UserModel _$result;
    try {
      _$result = _$v ??
          new _$UserModel._(
              name: name,
              phone: phone,
              address: address,
              picture: picture,
              preferences: _preferences?.build(),
              points: points,
              confirmedEvents: _confirmedEvents?.build(),
              events: _events?.build(),
              transactionHistory: _transactionHistory?.build(),
              uuid: uuid,
              friends: _friends?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'preferences';
        _preferences?.build();

        _$failedField = 'confirmedEvents';
        _confirmedEvents?.build();
        _$failedField = 'events';
        _events?.build();
        _$failedField = 'transactionHistory';
        _transactionHistory?.build();

        _$failedField = 'friends';
        _friends?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
