import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.text,
    this.type = TextInputType.text,
    this.obsureText = false,
    required this.onchange,
    required this.controller,
  });
  final String text;
  final TextInputType type;
  final bool obsureText;
  final Function(String) onchange;
  final TextEditingController controller;
  // final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        // onTap: onTap,
        controller: controller,
        onChanged: onchange,
        obscureText: obsureText,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintText: text,
          label: Text(
            text,
            style: TextStyle(
              color: Color(0xff303f7b),
            ),
          ),
        ),
      ),
    );
  }
}

class CardForm extends StatelessWidget {
  const CardForm(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 141,
        // width: 170,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Column(
            children: [
              Icon(
                icon,
                size: 100,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color(0xff303f7b),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  ProfileOptions(this.text, this.icon, this.onpressed);
  final String text;
  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 23,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}

class TransactionTiles extends StatelessWidget {
  const TransactionTiles({super.key, required this.type, required this.toName, required this.time, required this.amount, required this.text});
  final String type;
  final String toName;
  final String time;
  final int amount;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/profile.png"),
              radius: 30,
            ),
            Column(
              children: [
                Text(type),
                const SizedBox(height: 5,),
                Text(toName),
                const SizedBox(height: 5,),
                Text(time.substring(0,19),style:const TextStyle(fontSize: 14),),
              ],
            ),
            Column(
              children: [
                Text("\u{20B9} ${amount}",style: TextStyle(fontWeight: FontWeight.bold),),
                Text(text),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
