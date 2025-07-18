class DriverRideHistoryModel {
  bool? status;
  String? message;
  List<CompletedRides>? completedRides;
  List<CancelledRides>? cancelledRides;

  DriverRideHistoryModel({
    this.status,
    this.message,
    this.completedRides,
    this.cancelledRides,
  });

  DriverRideHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['completed_rides'] != null) {
      completedRides = <CompletedRides>[];
      json['completed_rides'].forEach((v) {
        completedRides!.add(new CompletedRides.fromJson(v));
      });
    }
    if (json['cancelled_rides'] != null) {
      cancelledRides = <CancelledRides>[];
      json['cancelled_rides'].forEach((v) {
        cancelledRides!.add(new CancelledRides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.completedRides != null) {
      data['completed_rides'] =
          this.completedRides!.map((v) => v.toJson()).toList();
    }
    if (this.cancelledRides != null) {
      data['cancelled_rides'] =
          this.cancelledRides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedRides {
  int? id;
  String? fromLocation;
  String? toLocation;
  String? date;
  String? startTime;
  double? amountReceived;
  String? paymentMethod;

  CompletedRides({
    this.id,
    this.fromLocation,
    this.toLocation,
    this.date,
    this.startTime,
    this.amountReceived,
    this.paymentMethod,
  });

  CompletedRides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    date = json['date'];
    startTime = json['start_time'];
    amountReceived = json['amount_received'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['amount_received'] = this.amountReceived;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}

class CancelledRides {
  int? id;
  String? fromLocation;
  String? toLocation;
  Null? date;
  Null? startTime;
  Null? amountReceived;
  Null? paymentMethod;

  CancelledRides({
    this.id,
    this.fromLocation,
    this.toLocation,
    this.date,
    this.startTime,
    this.amountReceived,
    this.paymentMethod,
  });

  CancelledRides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    date = json['date'];
    startTime = json['start_time'];
    amountReceived = json['amount_received'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['amount_received'] = this.amountReceived;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}
