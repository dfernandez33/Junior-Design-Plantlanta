// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:junior_design_plantlanta/model/activity_model.dart';

import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/model/transaction_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/model/user_preference.dart';
import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';

part 'seriliazers.g.dart';

@SerializersFor([
  EventModel,
  Datetime,
  UserRegistrationModel,
  UserPreferenceModel,
  ItemModel,
  UserModel,
  TransactionModel,
  ActivityModel
])
final Serializers serializers = _$serializers;

Serializers standardSerializers =
(serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();