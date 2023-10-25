import 'package:hive/hive.dart';

part 'survey_submit_response_data.g.dart';

@HiveType(typeId: 18)
class SurveySubmitResponseData {
  @HiveField(0)
  String? customerName;
  @HiveField(1)
  String? customerEmail;
  @HiveField(2)
  String? customerPhone;

  SurveySubmitResponseData({
    this.customerName,
    this.customerEmail,
    this.customerPhone,
  });

  factory SurveySubmitResponseData.fromJson(Map<String, dynamic> json) {
    return SurveySubmitResponseData(
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
    };
  }
}