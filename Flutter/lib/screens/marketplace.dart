import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_design_plantlanta/model/item_model.dart';
import 'package:junior_design_plantlanta/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Marketplace extends StatefulWidget {
  FirebaseUser currentUser;

  Marketplace() {
    getCurrentUser();
  }

  @override
  _MarketplaceState createState() => _MarketplaceState();

  void getCurrentUser() async {
    this.currentUser = await FirebaseAuth.instance.currentUser();
  }
}

class _MarketplaceState extends State<Marketplace> {
  final List<String> images = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
    "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
    "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",
  ];

  List<ItemModel> items;

  _MarketplaceState() {
    items = List();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
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
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Points: ",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                  Text(
                  "700 ",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                  Icon(
                    Icons.spa,
                    size: 14.0,
                    color: Theme.of(context).primaryColor,
                  ),]),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: this.items.length,
              itemBuilder: (BuildContext context, int index) =>
                  ItemCard(this.items[index]),
              staggeredTileBuilder: (int index) {
                return StaggeredTile.fit(2);
              },
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ));
    }
  }

  void _buildItemsModel() {
    _getItems();
  }

  Future<dynamic> _getItems() async {
    return Firestore.instance
        .collection("Items")
        .getDocuments()
        .asStream()
        .listen((data) {
      var items = data.documents;
      items.forEach((item) {
        this.items.add(ItemModel.fromJson(item.data));
        setState(() {});
      });
    });
  }
}
