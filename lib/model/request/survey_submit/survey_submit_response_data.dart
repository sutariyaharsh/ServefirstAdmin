class SurveySubmitResponseData {
  String? customerName;
  String? customerEmail;
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