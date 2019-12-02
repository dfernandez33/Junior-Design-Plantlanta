// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendRequestModel> _$friendRequestModelSerializer =
    new _$FriendRequestModelSerializer();

class _$FriendRequestModelSerializer
    implements StructuredSerializer<FriendRequestModel> {
  @override
  final Iterable<Type> types = const [FriendRequestModel, _$FriendRequestModel];
  @override
  final String wireName = 'FriendRequestModel';

  @override
  Iterable<Object> serialize(Serializers serializers, FriendRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sender',
      serializers.serialize(object.sender,
          specifiedType: const FullType(String)),
      'receiver',
      serializers.serialize(object.receiver,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FriendRequestModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sender':
          result.sender = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'receiver':
          result.receiver = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendRequestModel extends FriendRequestModel {
  @override
  final String sender;
  @override
  final String receiver;

  factory _$FriendRequestModel(
          [void Function(FriendRequestModelBuilder) updates]) =>
      (new FriendRequestModelBuilder()..update(updates)).build();

  _$FriendRequestModel._({this.sender, this.receiver}) : super._() {
    if (sender == null) {
      throw new BuiltValueNullFieldError('FriendRequestModel', 'sender');
    }
    if (receiver == null) {
      throw new BuiltValueNullFieldError('FriendRequestModel', 'receiver');
    }
  }

  @override
  FriendRequestModel rebuild(
          void Function(FriendRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendRequestModelBuilder toBuilder() =>
      new FriendRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendRequestModel &&
        sender == other.sender &&
        receiver == other.receiver;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sender.hashCode), receiver.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendRequestModel')
          ..add('sender', sender)
          ..add('receiver', receiver))
        .toString();
  }
}

class FriendRequestModelBuilder
    implements Builder<FriendRequestModel, FriendRequestModelBuilder> {
  _$FriendRequestModel _$v;

  String _sender;
  String get sender => _$this._sender;
  set sender(String sender) => _$this._sender = sender;

  String _receiver;
  String get receiver => _$this._receiver;
  set receiver(String receiver) => _$this._receiver = receiver;

  FriendRequestModelBuilder();

  FriendRequestModelBuilder get _$this {
    if (_$v != null) {
      _sender = _$v.sender;
      _receiver = _$v.receiver;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendRequestModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FriendRequestModel;
  }

  @override
  void update(void Function(FriendRequestModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FriendRequestModel build() {
    final _$result =
        _$v ?? new _$FriendRequestModel._(sender: sender, receiver: receiver);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
