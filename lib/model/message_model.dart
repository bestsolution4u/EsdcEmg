class MessageModel {
  int id;
  String urgentInd;
  String title;
  String modifier;
  String message;
  String location;
  String audience;
  String branch;
  String updatedDate;
  String category;
  String effectiveDate;
  String expiredDate;

  MessageModel(
      {this.id,
        this.urgentInd,
        this.title,
        this.modifier,
        this.message,
        this.location,
        this.audience,
        this.branch,
        this.updatedDate,
        this.category,
        this.effectiveDate,
        this.expiredDate});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urgentInd = json['urgent_ind'];
    title = json['title'];
    modifier = json['modifier'];
    message = json['message'];
    location = json['location'];
    audience = json['audience'];
    branch = json['branch'];
    updatedDate = json['updated_date'];
    category = json['category'];
    effectiveDate = json['effective_date'];
    expiredDate = json['expired_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urgent_ind'] = this.urgentInd;
    data['title'] = this.title;
    data['modifier'] = this.modifier;
    data['message'] = this.message;
    data['location'] = this.location;
    data['audience'] = this.audience;
    data['branch'] = this.branch;
    data['updated_date'] = this.updatedDate;
    data['category'] = this.category;
    data['effective_date'] = this.effectiveDate;
    data['expired_date'] = this.expiredDate;
    return data;
  }
}