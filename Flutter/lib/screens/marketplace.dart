import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/services/user_service.dart';
import 'package:junior_design_plantlanta/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Marketplace extends StatefulWidget {
  FirebaseUser currentUser;
  Future<dynamic> userStream;
  UserModel userData;
  UserService userService;
  String queryText;


  Marketplace(this.userService) {
    this.userService.getUserAuth().listen((user) {
      if (user != null) {
        this.userData = UserModel.fromJson(user.data);
      }
    });
  }

  @override
  _MarketplaceState createState() => _MarketplaceState();

  void getCurrentUser() async {
    this.currentUser = await FirebaseAuth.instance.currentUser();
    var user = await Firestore.instance.collection("Users").document(this.currentUser.uid).get();
    this.userData = UserModel.fromJson(user.data);
  }

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
                  ItemCard(this.items[index], widget.userData),
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
          this.items.add(ItemModel.fromJson(item.data));

        });
      });
    });
  }
}
