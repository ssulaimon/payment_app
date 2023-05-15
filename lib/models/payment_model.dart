class PaymentModel {
  String paymentType;
  String userName;
  int amount;
  String date;
  String sender;
  String reciever;
  PaymentModel({
    required this.amount,
    required this.date,
    required this.paymentType,
    required this.reciever,
    required this.sender,
    required this.userName,
  });
}
