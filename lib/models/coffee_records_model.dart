class CoffeeRecordsModel {
  final int id;
  final String title;
  final String des;
  double? amount;
  final DateTime date;

  CoffeeRecordsModel({
    required this.id,
    required this.title,
    required this.des,
    this.amount,
    required this.date,
  });

  factory CoffeeRecordsModel.fromJson(Map<String, dynamic> json) {
    return CoffeeRecordsModel(
      id: json["id"],
      title: json["title"],
      des: json["des"],
      amount: (json["amount"] as num?)?.toDouble(),
      date: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "des": des,
    "amount": amount,
    "date": date.toIso8601String(),
    "doc_id": id.toString(),
  };
}