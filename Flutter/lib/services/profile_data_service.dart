import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/model/transaction_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';

class ProfileDataService {
  Set<EventModel> currentEvents;
  Set<EventModel> pastEvents;
  Set<TransactionModel> transactions;
  StreamController<Set<TransactionModel>> streamTrans;
  StreamController<Set<EventModel>> streamCurrentEvents;
  StreamController<Set<EventModel>> streamPastEvents;
  UserModel _user;

  ProfileDataService(this._user) {
    this.transactions = LinkedHashSet();
    this.currentEvents = LinkedHashSet();
    this.pastEvents = LinkedHashSet();
    this.streamTrans = StreamController();
    this.streamCurrentEvents = StreamController();
    this.streamPastEvents = StreamController();

    Future.value(this._user).asStream().listen((user) {
      if (user != null) {
        getTransactions();
        getCurrentEvents();
        getPastEvents();
      }
    });
  }

  void getTransactions() {
    Firestore.instance
        .collection("Transactions")
        .where("uuid", isEqualTo: this._user.uuid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((transactions) {
          transactions.documents.forEach((transaction) {
            Timestamp timestamp = transaction.data["timestamp"];
            var tempTime = <String, dynamic>{
              "_nanoseconds": timestamp.nanoseconds,
              "_seconds": timestamp.seconds
            };
            transaction.data["timestamp"] = tempTime;
            this.transactions.add(TransactionModel.fromJson(transaction.data));
          });
          streamTrans.sink.add(this.transactions);
        });
  }

  void getCurrentEvents() {
    Firestore.instance
        .collection("Events")
        .where('passed', isEqualTo: false)
        .where('participants', arrayContains: this._user.uuid)
        .snapshots()
        .listen((events) {
      events.documents.forEach((event) {
        Timestamp timestamp = event.data['date'];
        var tempTime = <String, dynamic>{
          "_nanoseconds": timestamp.nanoseconds,
          "_seconds": timestamp.seconds
        };
        event.data['date'] = tempTime;
        this.currentEvents.add(EventModel.fromJson(event.data));
      });
      streamCurrentEvents.sink.add(this.currentEvents);
    });
  }

  void getPastEvents() {
    Firestore.instance
        .collection("Events")
        .where('passed', isEqualTo: true)
        .where('participants', arrayContains: this._user.uuid)
        .snapshots()
        .listen((events) {
      events.documents.forEach((event) {
        Timestamp timestamp = event.data['date'];
        var tempTime = <String, dynamic>{
          "_nanoseconds": timestamp.nanoseconds,
          "_seconds": timestamp.seconds
        };
        event.data['date'] = tempTime;
        this.pastEvents.add(EventModel.fromJson(event.data));
      });
      streamPastEvents.sink.add(this.pastEvents);
    });
  }

  StreamController<Set<TransactionModel>> transactionStream() {
    if (this.transactions.length != 0) {
      streamTrans.add(this.transactions);
    }
    return streamTrans;
  }

  StreamController<Set<EventModel>> currentEventStream() {
    if (this.currentEvents.length != 0) {
      streamCurrentEvents.add(this.currentEvents);
    }
    return streamCurrentEvents;
  }

  StreamController<Set<EventModel>> pastEventStream() {
    if (this.pastEvents.length != 0) {
      streamPastEvents.add(this.pastEvents);
    }
    return streamPastEvents;
  }
}