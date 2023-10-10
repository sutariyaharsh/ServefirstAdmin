import 'package:servefirst_admin/model/response/login/tour.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  Tour? _tour;
  @HiveField(1)
  String? _sId;
  @HiveField(2)
  String? _name;
  @HiveField(3)
  String? _email;
  @HiveField(4)
  String? _phone;
  @HiveField(5)
  String? _password;
  @HiveField(6)
  String? _type;
  @HiveField(7)
  String? _companyId;
  @HiveField(8)
  List<String>? _locationId;
  @HiveField(9)
  bool? _isActive;
  @HiveField(10)
  bool? _allowEmail;
  @HiveField(11)
  bool? _isShow;
  @HiveField(12)
  bool? _allowComplainMails;
  @HiveField(13)
  bool? _includeInRatings;
  @HiveField(14)
  String? _image;
  @HiveField(15)
  List<String>? _locationName;
  @HiveField(16)
  String? _sfv1OldUserId;
  @HiveField(17)
  String? _userEmailSettings;
  @HiveField(18)
  String? _createdAt;
  @HiveField(19)
  String? _updatedAt;
  @HiveField(20)
  int? _iV;

  User(
      {Tour? tour,
        String? sId,
        String? name,
        String? email,
        String? phone,
        String? password,
        String? type,
        String? companyId,
        List<String>? locationId,
        bool? isActive,
        bool? allowEmail,
        bool? isShow,
        bool? allowComplainMails,
        bool? includeInRatings,
        String? image,
        List<String>? locationName,
        String? sfv1OldUserId,
        String? userEmailSettings,
        String? createdAt,
        String? updatedAt,
        int? iV}) {
    if (tour != null) {
      this._tour = tour;
    }
    if (sId != null) {
      this._sId = sId;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (password != null) {
      this._password = password;
    }
    if (type != null) {
      this._type = type;
    }
    if (companyId != null) {
      this._companyId = companyId;
    }
    if (locationId != null) {
      this._locationId = locationId;
    }
    if (isActive != null) {
      this._isActive = isActive;
    }
    if (allowEmail != null) {
      this._allowEmail = allowEmail;
    }
    if (isShow != null) {
      this._isShow = isShow;
    }
    if (allowComplainMails != null) {
      this._allowComplainMails = allowComplainMails;
    }
    if (includeInRatings != null) {
      this._includeInRatings = includeInRatings;
    }
    if (image != null) {
      this._image = image;
    }
    if (locationName != null) {
      this._locationName = locationName;
    }
    if (sfv1OldUserId != null) {
      this._sfv1OldUserId = sfv1OldUserId;
    }
    if (userEmailSettings != null) {
      this._userEmailSettings = userEmailSettings;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (iV != null) {
      this._iV = iV;
    }
  }

  Tour? get tour => _tour;
  set tour(Tour? tour) => _tour = tour;
  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get companyId => _companyId;
  set companyId(String? companyId) => _companyId = companyId;
  List<String>? get locationId => _locationId;
  set locationId(List<String>? locationId) => _locationId = locationId;
  bool? get isActive => _isActive;
  set isActive(bool? isActive) => _isActive = isActive;
  bool? get allowEmail => _allowEmail;
  set allowEmail(bool? allowEmail) => _allowEmail = allowEmail;
  bool? get isShow => _isShow;
  set isShow(bool? isShow) => _isShow = isShow;
  bool? get allowComplainMails => _allowComplainMails;
  set allowComplainMails(bool? allowComplainMails) =>
      _allowComplainMails = allowComplainMails;
  bool? get includeInRatings => _includeInRatings;
  set includeInRatings(bool? includeInRatings) =>
      _includeInRatings = includeInRatings;
  String? get image => _image;
  set image(String? image) => _image = image;
  List<String>? get locationName => _locationName;
  set locationName(List<String>? locationName) => _locationName = locationName;
  String? get sfv1OldUserId => _sfv1OldUserId;
  set sfv1OldUserId(String? sfv1OldUserId) => _sfv1OldUserId = sfv1OldUserId;
  String? get userEmailSettings => _userEmailSettings;
  set userEmailSettings(String? userEmailSettings) =>
      _userEmailSettings = userEmailSettings;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  User.fromJson(Map<String, dynamic> json) {
    _tour = json['tour'] != null ? new Tour.fromJson(json['tour']) : null;
    _sId = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _type = json['type'];
    _companyId = json['company_id'];
    _locationId = json['location_id'].cast<String>();
    _isActive = json['is_active'];
    _allowEmail = json['allow_email'];
    _isShow = json['is_show'];
    _allowComplainMails = json['allow_complain_mails'];
    _includeInRatings = json['include_in_ratings'];
    _image = json['image'];
    _locationName = json['location_name'].cast<String>();
    _sfv1OldUserId = json['sfv1_old_user_id'];
    _userEmailSettings = json['user_email_settings'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._tour != null) {
      data['tour'] = this._tour!.toJson();
    }
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['password'] = this._password;
    data['type'] = this._type;
    data['company_id'] = this._companyId;
    data['location_id'] = this._locationId;
    data['is_active'] = this._isActive;
    data['allow_email'] = this._allowEmail;
    data['is_show'] = this._isShow;
    data['allow_complain_mails'] = this._allowComplainMails;
    data['include_in_ratings'] = this._includeInRatings;
    data['image'] = this._image;
    data['location_name'] = this._locationName;
    data['sfv1_old_user_id'] = this._sfv1OldUserId;
    data['user_email_settings'] = this._userEmailSettings;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['__v'] = this._iV;
    return data;
  }
}