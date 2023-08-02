import 'package:bank_app/components/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_screen.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Map<String, dynamic> currentUser = HomeScreen.currentUser;
  bool loading = true;
  List<Widget> transcation = [];

  void getData() async {
    QuerySnapshot sentTransactions = await FirebaseFirestore.instance
        .collection("Transactions")
        .where("from account num", isEqualTo: currentUser['Account Num'])
        .get();
    QuerySnapshot recievedTrasactions = await FirebaseFirestore.instance
        .collection("Transactions")
        .where("to account num", isEqualTo: currentUser['Account Num'])
        .get();
    for (var i in sentTransactions.docs) {
      transcation.add(TransactionTiles(
          type: "Sent",
          toName: i["to name"],
          time: (i["time"] as Timestamp).toDate().toString(),
          amount: i["amount"],
          text: "Debited from account"));
    }
    for (var i in recievedTrasactions.docs) {
      transcation.add(TransactionTiles(
          type: "Recieved",
          toName: i["from name"],
          time: (i["time"] as Timestamp).toDate().toString(),
          amount: i["amount"],
          text: "Credited to account"));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: const Color(0xff303f7b),
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body:(loading)? Center(child: CircularProgressIndicator(),) :Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: transcation
        ),
      ),
    );
  }
}
