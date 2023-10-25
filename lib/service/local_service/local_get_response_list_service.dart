import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/model/response/response_list/responses_data.dart';

class LocalGetResponseListService {
  late Box<ResponsesData> _responsesDataBox;

  Future<void> init() async {
    _responsesDataBox = await Hive.openBox<ResponsesData>('ResponsesData');
  }

  Future<void> assignAllResponsesData({required List<ResponsesData> responsesData}) async {
    await _responsesDataBox.clear();
    await _responsesDataBox.addAll(responsesData);
  }

  Future<void> clear() async {
    await _responsesDataBox.clear();
  }

  List<ResponsesData>? getResponseData() => _responsesDataBox.values.toList();
}
