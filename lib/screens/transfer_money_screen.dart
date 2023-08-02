import 'package:bank_app/constants/route_constants.dart';
import 'package:bank_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({super.key});
  static String? uid = "";

  @override
  State<TransferMoney> createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {

  void getUsers() {}

  @override
  Widget build(BuildContext context) {
    final controller_text = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        title: const Text("Transfer Money"),
        backgroundColor: const Color(0xff303f7b),
        leading: IconButton(
          onPressed: () {
            context.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 3,
              bottom: 8,
            ),
            child: TextField(
              controller: controller_text,
              onTap: () {},
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Search Account by account number",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    setState(() {
                      controller_text.clear();
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot != null) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (ctx, index) {
                        if (SplashScreen.userEmail !=
                            snapshot.data?.docs[index]['Email']) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  TransferMoney.uid = snapshot.data?.docs[index].id;
                                });
                                context.push(RouteConstants.sendMoney);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(snapshot.data?.docs[index]
                                      ['Account Num']),
                                  subtitle: Text(
                                      "${snapshot.data?.docs[index]['PhoneNum']}\n${snapshot.data?.docs[index]['Email']}"),
                                  isThreeLine: true,
                                  leading: const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage("images/profile.png"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
