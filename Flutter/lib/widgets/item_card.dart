import 'package:junior_design_plantlanta/model/user.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';

import 'package:junior_design_plantlanta/widgets/progress_dialog.dart';

class ItemCard extends StatefulWidget {
  ItemModel _model;
  bool showDetails = false;
  UserModel userData;

  ItemCard(this._model, this.userData);

  bool get isSelected => this.isSelected;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Widget _buildPopUpContent() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Center(
              child: Image.network(widget._model.imageSrc),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                widget._model.description,
              )),
          Container(
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget._model.price.toString(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0),
                    ),
                    Icon(
                      Icons.spa,
                      size: 20.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              if (widget.userData.points >= widget._model.price) {
                return ProgressDialog(confirmPurchase, _buildPopUpContent(),
                    "Buy Now", widget._model.name, true);
              } else {
                return _notEnoughPointsDialog();
              }
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(2.0),
                    child: Opacity(
                        opacity: widget.userData.points >= widget._model.price ? 1.0 : 0.2,
                        child:Image.network(widget._model.imageSrc),
                    ),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(widget._model.name,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight
                              .w500)), //Limit character for name items to 24
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget._model.price.toString(),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    Icon(
                      Icons.spa,
                      size: 14.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notEnoughPointsDialog() {
    return AlertDialog(
      title: new Text("Not Enough Points"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(
            "Close",
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color(0xFF25A325)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<StatusResponse> confirmPurchase() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'purchaseItem',
    );
    try {
      final HttpsCallableResult result = await callable
          .call(<String, dynamic>{"ItemID": widget._model.itemId});
      StatusResponse resp = new StatusResponse.fromJson(result.data);
      return(resp);
    } catch (e) {
      print(e.message);
    }
  }
}
