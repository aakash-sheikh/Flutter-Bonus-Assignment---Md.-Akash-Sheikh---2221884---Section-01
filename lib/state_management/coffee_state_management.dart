import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';


class CoffeeStateManagement with ChangeNotifier {
  List<CoffeeRecordsModel> items = [];

  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee_records');

  void addData(){
    items.add(
      CoffeeRecordsModel(
        id: DateTime.now().microsecondsSinceEpoch,
        title: "Coffee Record ${items.length + 1}",
        des: "Details about Coffee Record ${items.length + 1}",
        amount: 10.0,
        date: DateTime.now(),
      )
    );

    notifyListeners();
  }


  void addCoffeeRecord(CoffeeRecordsModel coffeeRecord) async {
    final CoffeeRecordsModel newRecord = CoffeeRecordsModel(
      id: DateTime.now().microsecondsSinceEpoch,
      title: coffeeRecord.title,
      des: coffeeRecord.des,
      amount: coffeeRecord.amount,
      date: coffeeRecord.date,
    );

    await coffeeCollection.doc(newRecord.id.toString()).set(newRecord.toJson());

    notifyListeners();
  }

  void updateCoffeeRecord(CoffeeRecordsModel coffeeRecord) async {
    await coffeeCollection.doc(coffeeRecord.id.toString()).update(coffeeRecord.toJson());
    notifyListeners();
  }

  void deleteCoffeeRecord(int id) async {
    await coffeeCollection.doc(id.toString()).delete();
    notifyListeners();
  }

  Stream<List<CoffeeRecordsModel>> get coffeeRecordsStream {
    return coffeeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CoffeeRecordsModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}