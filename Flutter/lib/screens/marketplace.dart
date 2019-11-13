import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/services/algolia_service.dart';
import 'package:junior_design_plantlanta/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Marketplace extends StatefulWidget {
  UserModel userData;

  Marketplace(this.userData);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

// TODO: Improve Progress Dialog to respond to error/success.
class _MarketplaceState extends State<Marketplace> {
  bool isLoading;
  Future<dynamic> itemStream;
  List<ItemModel> items;
  List rawItems;
  AlgoliaIndexReference algolia =
      AlgoliaService.algolia.instance.index('Items');

  _MarketplaceState() {
    items = List();
    rawItems = List();
    this.itemStream = _getItems();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && widget.userData != null) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )),
      );
    } else {
      Widget content;
      if (this.items.length == 0) {
        content = Center(
          child: Text("No Items Found"),
        );
      } else {
        content = Padding(
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
        );
      }
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 2.0,
          title: Column(children: [
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration:
                  InputDecoration(hintText: 'Search items by name or brand'),
              onChanged: (text) {
                _updateFilteredItems(text);
              },
            ),
          ]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: content,
        ),
      );
    }
  }

  Future<dynamic> _getItems() async {
    this.isLoading = true;
    return Firestore.instance
        .collection("Items")
        .getDocuments()
        .asStream()
        .listen((data) {
      var items = data.documents;
      setState(() {
        items.forEach((item) {
          item.data.addEntries([MapEntry("itemID", item.reference.documentID)]);
          this.rawItems.add(item.data);
          this.items.add(ItemModel.fromJson(item.data));
        });
        this.isLoading = false;
      });
    });
  }

  _updateFilteredItems(String query) {
    this.algolia.search(query).getObjects().then((results) {
      List hitIDs = results.hits.map((hit) => hit.objectID).toList();
      List updatedItems = this
          .rawItems
          .where((item) => hitIDs.contains(item['itemID']))
          .toList();
      setState(() {
        this.items =
            updatedItems.map((item) => ItemModel.fromJson(item)).toList();
      });
    });
  }
}
