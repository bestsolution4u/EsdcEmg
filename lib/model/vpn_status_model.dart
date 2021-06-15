import 'dart:convert';

class VPNStatusModel {
  String sitename, status, usage, description;

  VPNStatusModel({this.sitename, this.status, this.usage, this.description});

  VPNStatusModel.fromJson(Map<String, dynamic> json) {
    sitename = json['gate'];
    status = json['status'];
    usage = json['bandwidth'].toString();
    try {
      int bandwidth = json['bandwidth'];
      if (bandwidth > 95) {
        description = 'BAD';
      } else if (bandwidth > 75) {
        description = 'MODERATE';
      } else {
        description = 'GOOD';
      }
    } catch (e) {
      description = 'GOOD';
    }
  }

  String toString() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sitename'] = this.sitename;
    data['status'] = this.status;
    data['usage'] = this.usage;
    data['description'] = this.description;
    return jsonEncode(data);
  }

  VPNStatusModel.fromString(String values) {
    Map<String, dynamic> json = jsonDecode(values);
    if (json == null) return;
    sitename = json['sitename'];
    status = json['status'];
    usage = json['usage'];
    description = json['description'];
  }
}