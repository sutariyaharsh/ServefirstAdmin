import 'package:hive/hive.dart';

part 'tour.g.dart';

@HiveType(typeId: 2)
class Tour {
  @HiveField(0)
  String? _status;

  Tour({String? status}) {
    if (status != null) {
      this._status = status;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;

  Tour.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    return data;
  }
}