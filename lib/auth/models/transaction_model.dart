class TransactionModel {
  const TransactionModel(
      {this.id,
      required this.fromAccNum,
      required this.toAccountNum,
      required this.amount,
      required this.fromName,
      required this.toName,
      // required this.description,
      required this.time});

  final String? id;
  final String fromAccNum;
  final String toAccountNum;
  final int amount;
  final String fromName;
  final String toName;
  // final String description;
  final DateTime time;

  toJson() {
    return {
      "from account num": fromAccNum,
      "to account num": toAccountNum,
      "amount":amount,
      "from name":fromName,
      "to name":toName,
      // "description":description,
      "time":time
    };
  }
}
