class VPNStatusModel {
  String sitename, status, usage, description;

  VPNStatusModel({this.sitename, this.status, this.usage, this.description});

  VPNStatusModel.fromJson(Map<String, dynamic> json) {
    sitename = json['gate'];
    status = json['status'];
    usage = json['bandwidth'].toString();
    try {
      int bandwidth = json['bandwidth'];
      if (bandwidth > 90) {
        description = 'BAD';
      } else if (bandwidth > 30) {
        description = 'MODERATE';
      } else {
        description = 'GOOD';
      }
    } catch (e) {
      description = 'GOOD';
    }
  }
}