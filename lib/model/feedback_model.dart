class FeedbackModel {
  int id;
  String name;
  String feedback;
  String category;

  FeedbackModel(
      {this.id,
        this.name,
        this.feedback,
        this.category});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feedback = json['feedback'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['feedback'] = this.feedback;
    data['category'] = this.category;
    return data;
  }
}