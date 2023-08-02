import 'package:bank_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:go_router/go_router.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  Map<String, dynamic> currentUser = HomeScreen.currentUser;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loading = false;
    // getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance"),
        backgroundColor: const Color(0xff303f7b),
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Center(
        child: (loading)
            ? const CircularProgressIndicator()
            : CreditCardWidget(
                cardNumber: currentUser['Account Num'].toString(),
                expiryDate: "",
                cardHolderName: currentUser['FullName'].toString(),
                cvvCode: "\u{20B9} ${currentUser['Money'].toString()}",
                bankName: 'Axis Bank',
                showBackView: false,
                obscureCardNumber: false,
                obscureCardCvv: false,
                isHolderNameVisible: true,
                cardBgColor: Colors.blueGrey.shade700,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/images.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
