import 'package:hive/hive.dart';

part 'image_names.g.dart';

@HiveType(typeId: 15)
class ImageNames {
  @HiveField(0)
  String? imageName;

  ImageNames({this.imageName});

  factory ImageNames.fromJson(Map<String, dynamic> json) {
    return ImageNames(
      imageName: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': imageName,
    };
  }
}
