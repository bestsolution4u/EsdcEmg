class VPNStatusModel {
  String sitename, status, usage, description;

  VPNStatusModel({this.sitename, this.status, this.usage, this.description});

  VPNStatusModel.fromJson(Map<String, dynamic> json) {
    sitename = json['sitename'];
    status = json['status'];
    usage = json['usage'];
    description = json['description'];
  }
}