import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/widgets/progress_dialog.dart';

class ItemCard extends StatefulWidget {
  ItemModel _model;
  bool showDetails = false;

  ItemCard(this._model);

  bool get isSelected => this.isSelected;
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  Widget _buildPopUpContent() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Image.network(widget._model.imageSrc),
            ),
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
              return ProgressDialog(() {},
                Text("kike"),
                "Buy Now",
                widget._model.name,
                true
              );
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
                    child: Image.network(widget._model.imageSrc),
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
}
