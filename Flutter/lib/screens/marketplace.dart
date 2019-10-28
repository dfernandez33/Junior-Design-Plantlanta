import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/services/user_service.dart';
import 'package:junior_design_plantlanta/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Marketplace extends StatefulWidget {
  UserModel userData;
  String queryText;


  Marketplace(this.userData);

  @override
  _MarketplaceState createState() => _MarketplaceState();

}

class _MarketplaceState extends State<Marketplace> {

  Future<dynamic> itemStream;
  List<ItemModel> items;
  
  _MarketplaceState() {
    items = List();
    this.itemStream = _getItems();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty || widget.userData == null) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )),
      );
    } else {
      return Scaffold(
          appBar: new AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 2.0,
              title: Column(children: [
                TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      hintText: 'Enter a search term'
                  ),
                  onChanged: (text) {
                    widget.queryText = text;

                  },
                ),
              ])),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: this.items.length,
              itemBuilder: (BuildContext context, int index) =>
                  ItemCard(this.items[index], this.widget.userData),
              staggeredTileBuilder: (int index) {
                return StaggeredTile.fit(2);
              },
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ));
    }
  }

  Future<dynamic> _getItems() async {
    return Firestore.instance
        .collection("Items")
        .getDocuments()
        .asStream()
        .listen((data) {
      var items = data.documents;
      setState(() {
        items.forEach((item) {
          // TODO: Pass ID.
          this.items.add(ItemModel.fromJson(item.data));

        });
      });
    });
  }
}
