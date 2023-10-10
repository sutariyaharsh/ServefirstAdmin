import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/response/location_survey/employee.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';

part 'location.g.dart';
@HiveType(typeId: 5)
class Location {
  @HiveField(0)
  String? _sId;
  @HiveField(1)
  String? _companyId;
  @HiveField(2)
  String? _name;
  @HiveField(3)
  String? _address1;
  @HiveField(4)
  String? _address2;
  @HiveField(5)
  double? _longitude;
  @HiveField(6)
  double? _latitude;
  @HiveField(7)
  List<Employee>? _employee;
  @HiveField(8)
  String? _distance;
  @HiveField(9)
  List<Survey>? _surveys;

  Location(
      {String? sId,
        String? companyId,
        String? name,
        String? address1,
        String? address2,
        double? longitude,
        double? latitude,
        List<Employee>? employee,
        String? distance,
        List<Survey>? surveys}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (companyId != null) {
      this._companyId = companyId;
    }
    if (name != null) {
      this._name = name;
    }
    if (address1 != null) {
      this._address1 = address1;
    }
    if (address2 != null) {
      this._address2 = address2;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (employee != null) {
      this._employee = employee;
    }
    if (distance != null) {
      this._distance = distance;
    }
    if (surveys != null) {
      this._surveys = surveys;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get companyId => _companyId;
  set companyId(String? companyId) => _companyId = companyId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get address1 => _address1;
  set address1(String? address1) => _address1 = address1;
  String? get address2 => _address2;
  set address2(String? address2) => _address2 = address2;
  double? get longitude => _longitude;
  set longitude(double? longitude) => _longitude = longitude;
  double? get latitude => _latitude;
  set latitude(double? latitude) => _latitude = latitude;
  List<Employee>? get employee => _employee;
  set employee(List<Employee>? employee) => _employee = employee;
  String? get distance => _distance;
  set distance(String? distance) => _distance = distance;
  List<Survey>? get surveys => _surveys;
  set surveys(List<Survey>? surveys) => _surveys = surveys;

  Location.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _companyId = json['company_id'];
    _name = json['name'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    if (json['employee'] != null) {
      _employee = <Employee>[];
      json['employee'].forEach((v) {
        _employee!.add(new Employee.fromJson(v));
      });
    }
    _distance = json['distance'];
    if (json['surveys'] != null) {
      _surveys = <Survey>[];
      json['surveys'].forEach((v) {
        _surveys!.add(new Survey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['company_id'] = this._companyId;
    data['name'] = this._name;
    data['address_1'] = this._address1;
    data['address_2'] = this._address2;
    data['longitude'] = this._longitude;
    data['latitude'] = this._latitude;
    if (this._employee != null) {
      data['employee'] = this._employee!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this._distance;
    if (this._surveys != null) {
      data['surveys'] = this._surveys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}