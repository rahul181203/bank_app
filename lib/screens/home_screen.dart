import 'package:bank_app/components/widgets.dart';
import 'package:bank_app/constants/route_constants.dart';
import 'package:bank_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static Map<String, dynamic> currentUser = {};
  static String dataID = "";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  void getUser() async {
    QuerySnapshot user = await FirebaseFirestore.instance
        .collection("Users")
        .where('Email', isEqualTo: SplashScreen.userEmail)
        .get();
    final data = user.docs[0].data() as Map<String, dynamic>;
    final dataid = user.docs[0].id;
    setState(() {
      HomeScreen.currentUser = data;
      HomeScreen.dataID = dataid;
      loading = false;
    });
  }

  Future refresh() async {
    setState(() {
      loading = true;
    });
    getUser();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "BANK APP",
            style: TextStyle(color: Color(0xff303f7b)),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                context.push(RouteConstants.profile);
              },
              icon: const Icon(
                Icons.supervised_user_circle,
                color: Colors.black,
              ),
            ),
          ]),
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Image(image: AssetImage("images/home.jpg")),
                    const Divider(),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          CardForm(
                              icon: Icons.attach_money,
                              text: "Transfer Money",
                              onPressed: () {
                                context.push(RouteConstants.transfer);
                              }),
                          CardForm(
                              icon: Icons.qr_code,
                              text: "QR Scanner",
                              onPressed: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          CardForm(
                              icon: Icons.account_balance_wallet,
                              text: "Balance",
                              onPressed: () {
                                context.push(RouteConstants.balance);
                              }),
                          CardForm(
                              icon: Icons.add_chart_outlined,
                              text: "History",
                              onPressed: () {
                                context.push(RouteConstants.histroy);
                              }),
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
