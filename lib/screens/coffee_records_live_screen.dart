import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';
import 'package:summer_iub_app/state_management/coffee_state_management.dart';
import 'package:summer_iub_app/widgets/app_backgroud_design_widget.dart';

class CoffeeRecordsLiveScreen extends StatelessWidget {
  const CoffeeRecordsLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final csm = Provider.of<CoffeeStateManagement>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coffee Records (Live)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.00,
          ),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: AppBackgroudDesignWidget(
        child: StreamBuilder<List<CoffeeRecordsModel>>(
          stream: csm.coffeeRecordsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final records = snapshot.data ?? [];

            if (records.isEmpty) {
              return Center(child: Text("No coffee records yet"));
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final CoffeeRecordsModel coffeeRecord = records[index];

                return Card(
                  child: ListTile(
                    leading: Icon(Icons.coffee),
                    title: Text(coffeeRecord.title),
                    subtitle: Text(
                        "${coffeeRecord.des} - Amount: ${coffeeRecord.amount} - ID: (${coffeeRecord.id})"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        csm.deleteCoffeeRecord(coffeeRecord.id);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}