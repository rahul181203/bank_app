import 'package:bank_app/auth/models/transaction_model.dart';
import 'package:bank_app/constants/route_constants.dart';
import 'package:bank_app/screens/home_screen.dart';
import 'package:bank_app/screens/transfer_money_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final loggedinuser = HomeScreen.currentUser;
  bool loading = true;
  final controller = TextEditingController();
  String accnum = "";
  String name = "";
  String email = "";
  String mobilenum = "";
  String balance = "";

  void getUser() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection("Users")
        .doc(TransferMoney.uid)
        .get();
    final data = user.data() as Map<String, dynamic>;
    accnum = data['Account Num'].toString();
    name = data['FullName'].toString();
    email = data['Email'].toString();
    mobilenum = data['PhoneNum'].toString();
    balance = data['Money'].toString();
    setState(() {
      loading = false;
    });
  }

  void updateDB(int amount) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(TransferMoney.uid)
          .update({"Money": amount + int.parse(balance)}).then((value) => null);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
    }
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(HomeScreen.dataID)
          .update({"Money": loggedinuser['Money'] - amount}).then(
              (value) => null);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
    }
  }

  void generateTrasaction() async {
    int amount = int.parse(controller.text);
    if ((loggedinuser['Money']) >= amount) {
      TransactionModel t = TransactionModel(
          amount: amount,
          fromAccNum: loggedinuser['Account Num'].toString(),
          fromName: loggedinuser['FullName'].toString(),
          time: DateTime.timestamp(),
          toAccountNum: accnum,
          toName: name);
      try {
        await FirebaseFirestore.instance
            .collection("Transactions")
            .add(t.toJson())
            .whenComplete(() => Fluttertoast.showToast(
                msg: "Transaction Successfull", gravity: ToastGravity.BOTTOM));
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
      }
      updateDB(amount);
      setState(() {
        loading = false;
      });
      context.push(RouteConstants.histroy);
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: "Balance Insufficient", gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Money"),
        backgroundColor: const Color(0xff303f7b),
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Image.asset(
                    "images/profile.png",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Account Num:  $accnum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Full Name:  $name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email:  $email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mobile Num:  $mobilenum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Color(0xff303f7b))),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "\u{20B9}",
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: size.width * 0.55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff303f7b)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: TextField(
                          style: TextStyle(),
                          keyboardType: TextInputType.number,
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: " Enter Amount",
                            focusedBorder: InputBorder.none,
                            // border: OutlineInputBorder(borderSide: BorderSide.none,)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loading = true;
                      generateTrasaction();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      backgroundColor: const Color(0xff303f7b),
                    ),
                    child: const Text("Transfer"),
                  )
                ],
              ),
            ),
    );
  }
}
