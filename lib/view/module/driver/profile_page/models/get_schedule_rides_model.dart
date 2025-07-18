class UpcomigScheduledModel {
  bool? status;
  String? message;
  List<Data>? data;

  UpcomigScheduledModel({this.status, this.message, this.data});

  UpcomigScheduledModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fromLocation;
  String? toLocation;
  String? scheduledDate;
  String? scheduledTime;

  Data({
    this.id,
    this.fromLocation,
    this.toLocation,
    this.scheduledDate,
    this.scheduledTime,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    scheduledDate = json['scheduled_date'];
    scheduledTime = json['scheduled_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['scheduled_date'] = this.scheduledDate;
    data['scheduled_time'] = this.scheduledTime;
    return data;
  }
}
