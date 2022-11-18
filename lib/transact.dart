class transact {
  String? id;
  String? date;
  String? type;
  String? amount;
  String? reason;
  String? userid;

  transact(
      {this.id, this.date, this.type, this.amount, this.reason, this.userid});

  transact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    amount = json['amount'];
    reason = json['reason'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['reason'] = this.reason;
    data['userid'] = this.userid;
    return data;
  }
}
