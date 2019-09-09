// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserRegistrationModel> _$userRegistrationModelSerializer =
    new _$UserRegistrationModelSerializer();

class _$UserRegistrationModelSerializer
    implements StructuredSerializer<UserRegistrationModel> {
  @override
  final Iterable<Type> types = const [
    UserRegistrationModel,
    _$UserRegistrationModel
  ];
  @override
  final String wireName = 'UserRegistrationModel';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UserRegistrationModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.dob != null) {
      result
        ..add('dob')
        ..add(serializers.serialize(object.dob,
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
    if (object.preference != null) {
      result
        ..add('preference')
        ..add(serializers.serialize(object.preference,
            specifiedType: const FullType(UserPreferenceModel)));
    }
    return result;
  }

  @override
  UserRegistrationModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserRegistrationModelBuilder();

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
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dob':
          result.dob = serializers.deserialize(value,
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
        case 'preference':
          result.preference.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserPreferenceModel))
              as UserPreferenceModel);
          break;
      }
    }

    return result.build();
  }
}

class _$UserRegistrationModel extends UserRegistrationModel {
  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String dob;
  @override
  final String phone;
  @override
  final String address;
  @override
  final UserPreferenceModel preference;

  factory _$UserRegistrationModel(
          [void Function(UserRegistrationModelBuilder) updates]) =>
      (new UserRegistrationModelBuilder()..update(updates)).build();

  _$UserRegistrationModel._(
      {this.name,
      this.email,
      this.password,
      this.dob,
      this.phone,
      this.address,
      this.preference})
      : super._();

  @override
  UserRegistrationModel rebuild(
          void Function(UserRegistrationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserRegistrationModelBuilder toBuilder() =>
      new UserRegistrationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserRegistrationModel &&
        name == other.name &&
        email == other.email &&
        password == other.password &&
        dob == other.dob &&
        phone == other.phone &&
        address == other.address &&
        preference == other.preference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, name.hashCode), email.hashCode),
                        password.hashCode),
                    dob.hashCode),
                phone.hashCode),
            address.hashCode),
        preference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserRegistrationModel')
          ..add('name', name)
          ..add('email', email)
          ..add('password', password)
          ..add('dob', dob)
          ..add('phone', phone)
          ..add('address', address)
          ..add('preference', preference))
        .toString();
  }
}

class UserRegistrationModelBuilder
    implements Builder<UserRegistrationModel, UserRegistrationModelBuilder> {
  _$UserRegistrationModel _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _dob;
  String get dob => _$this._dob;
  set dob(String dob) => _$this._dob = dob;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  UserPreferenceModelBuilder _preference;
  UserPreferenceModelBuilder get preference =>
      _$this._preference ??= new UserPreferenceModelBuilder();
  set preference(UserPreferenceModelBuilder preference) =>
      _$this._preference = preference;

  UserRegistrationModelBuilder();

  UserRegistrationModelBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _email = _$v.email;
      _password = _$v.password;
      _dob = _$v.dob;
      _phone = _$v.phone;
      _address = _$v.address;
      _preference = _$v.preference?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserRegistrationModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserRegistrationModel;
  }

  @override
  void update(void Function(UserRegistrationModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserRegistrationModel build() {
    _$UserRegistrationModel _$result;
    try {
      _$result = _$v ??
          new _$UserRegistrationModel._(
              name: name,
              email: email,
              password: password,
              dob: dob,
              phone: phone,
              address: address,
              preference: _preference?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'preference';
        _preference?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserRegistrationModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
