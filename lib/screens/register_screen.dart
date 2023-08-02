import 'dart:math';
// import 'dart:developer';
import 'package:bank_app/auth/models/user_model.dart';
import 'package:bank_app/auth/operations/user_repository.dart';
import 'package:bank_app/components/widgets.dart';
import 'package:bank_app/constants/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool dob = false;
  bool loading = false;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  DateTime datetime = DateTime(2023, 07, 19, 05, 30);

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200));

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: controller2.text.trim(), password: controller3.text.trim());
      newUser();
      setState(() {
        loading = false;
      });
      if (!context.mounted) return;
      context.go(RouteConstants.home);
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
    }
  }

  String getAccountNum() {
    String accountnum = "";
    for (int i = 0; i < 10; i++) {
      accountnum = accountnum + Random().nextInt(10).toString();
    }
    return accountnum;
  }

  void newUser() {
    UserModel u = UserModel(
        name: controller1.text,
        email: controller2.text,
        dateOfBirth: "${datetime.day} - ${datetime.month} - ${datetime.year}",
        accountNum: getAccountNum(),
        phonenum: controller4.text,
        password: controller3.text,
        money: 0);

    UserRepository().createUser(u);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Image(
                    image: AssetImage(
                      "images/register.png",
                    ),
                    width: 150,
                  ),
                  TextInput(
                    text: "Name",
                    onchange: (value) {},
                    controller: controller1,
                  ),
                  TextInput(
                    text: "Email",
                    onchange: (value) {},
                    controller: controller2,
                  ),
                  TextInput(
                    obsureText: true,
                    text: "Password",
                    onchange: (value) {},
                    controller: controller3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black,
                      ),
                      // label: CustomText("End Date & Time",Color(0xff979797),14,FontWeight.w600),
                      label: Text(
                        (dob)
                            ? "${datetime.day} - ${datetime.month} - ${datetime.year}"
                            : "date of birth",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        DateTime? date = await pickDate();
                        if (date == null) return;
                        final dt = DateTime(
                          date.year,
                          date.month,
                          date.day,
                        );
                        setState(() {
                          dob = true;
                          datetime = dt;
                        });
                      },
                    ),
                  ),
                  TextInput(
                    text: "Phone number",
                    type: TextInputType.number,
                    onchange: (value) {},
                    controller: controller4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff303f7b),
                          ),
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            signUp();
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
