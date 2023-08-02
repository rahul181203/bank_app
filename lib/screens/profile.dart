import 'package:bank_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../components/widgets.dart';
import '../constants/route_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> currentUser = HomeScreen.currentUser;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // getUser();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xff303f7b),
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: Color(0xfffafafa), boxShadow: [
                      BoxShadow(blurRadius: 11),
                    ]),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage("images/profile.png"),
                          radius: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          currentUser['FullName'].toString(),
                          style: TextStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(currentUser['Email'].toString(),
                            style: TextStyle()),
                        SizedBox(
                          height: 5,
                        ),
                        Text("+91 - ${currentUser['PhoneNum'].toString()}",
                            style: TextStyle()),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileOptions(
                    "Saved Listing addresses", Icons.location_history, () {}),
                ProfileOptions("Bank Account Number", Icons.warehouse, () {
                  Fluttertoast.showToast(
                      msg: currentUser['Account Num'].toString(),
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                }),
                ProfileOptions("FAQs", Icons.question_mark_outlined, () {}),
                ProfileOptions("Help & Support", Icons.support_agent, () {}),
                ProfileOptions("Policies", Icons.menu_book_sharp, () {}),
                ProfileOptions("Logout", Icons.logout, () {
                  FirebaseAuth.instance
                      .signOut()
                      .whenComplete(() => context.go(RouteConstants.login));
                }),
              ],
            ),
    );
  }
}
