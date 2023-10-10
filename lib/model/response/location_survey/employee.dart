import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'employee.g.dart';

@HiveType(typeId: 6)
class Employee {
  @HiveField(0)
  String? _locationId;
  @HiveField(1)
  String? _name;
  @HiveField(2)
  String? _id;
  @HiveField(3)
  String? _image;

  Employee({String? locationId, String? name, String? id, String? image}) {
    if (locationId != null) {
      this._locationId = locationId;
    }
    if (name != null) {
      this._name = name;
    }
    if (id != null) {
      this._id = id;
    }
    if (image != null) {
      this._image = image;
    }
  }

  String? get locationId => _locationId;

  set locationId(String? locationId) => _locationId = locationId;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get image => _image;

  set image(String? image) => _image = image;

  Employee.fromJson(Map<String, dynamic> json) {
    _locationId = json['location_id'];
    _name = json['name'];
    _id = json['id'];
    _image = json['image'];
    // Download and store the image path
    /*String imageUrl = json['image'];
    _downloadAndStoreImage(imageUrl, _id!).then((value) => {_image = value});*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this._locationId;
    data['name'] = this._name;
    data['id'] = this._id;
    data['image'] = this._image;
    return data;
  }

  Future<String?> _downloadAndStoreImage(String imageUrl, String id) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Get the temporary directory for the app
        final appDir = await getTemporaryDirectory();
        final imagePath =
            "${appDir.path}/$id.png";

        // Write the image data to the file
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        print("imagePath - $imagePath");
        _image = imagePath;
        return imagePath;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return imageUrl;
    }

    // Return null if there's an error or if the image couldn't be downloaded
    return imageUrl;
  }
}
