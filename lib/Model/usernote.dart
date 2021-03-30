class UserNote {
  String id;
  String userId;
  String title;
  String detail;
  String date;
  String time;
  String createDate;
  String updateDate;
  String state;

  UserNote(
      {this.id,
      this.userId,
      this.title,
      this.detail,
      this.date,
      this.time,
      this.createDate,
      this.updateDate,
      this.state});

  UserNote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    detail = json['detail'];
    date = json['date'];
    time = json['time'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['date'] = this.date;
    data['time'] = this.time;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['state'] = this.state;
    return data;
  }
}
