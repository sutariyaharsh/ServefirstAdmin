class ResponseListRequest {
  final String userId;
  final int page;

  ResponseListRequest({
    required this.userId,
    required this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'page': page,
    };
  }
}
