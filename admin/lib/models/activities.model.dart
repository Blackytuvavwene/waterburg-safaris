// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/models/company.model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

// include freezed related files
part 'activities.model.freezed.dart';
part 'activities.model.g.dart';

@Freezed()
class Activity with _$Activity {
  @JsonSerializable(
    explicitToJson: true,
    anyMap: true,
  )
  factory Activity({
    final String? activityId,
    final String? activityName,
    final String? seoDescription,
    final String? slug,
    final List<String>? tags,
    final List<Package>? packages,
    final List<Gallery>? activityGallery,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? overview,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

@Freezed()
class Package with _$Package {
  @JsonSerializable(
    explicitToJson: true,
    anyMap: true,
  )
  factory Package({
    final String? packageId,
    final String? packageName,
    final List<String>? keywords,
    final String? description,
    final double? price,
    final double? lastPrice,
    final double? rating,
    final double? discountPercentage,
    final String? coupon,
    final List<String>? packageOffers,
    final String? slug,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}

// model class to help with image xfile and imagefile
@Freezed()
class ImageHelperModel with _$ImageHelperModel {
  factory ImageHelperModel({
    required final XFile? xFile,
    required final String? name,
    required final String? path,
    required final Uint8List? bytes,
    required final ImageFile? imageFile,
    required final Gallery? imageDetails,
  }) = _ImageHelperModel;
}

// xfile json
// @Freezed()
// class XFileJson with _$XFileJson {
//   factory XFileJson({
//     final String? path,
//     final String? mimeType,
//     final String? name,
//     final int? length,
//     final Uint8List? bytes,
//     final DateTime? lastModified,
//   }) = _XFileJson;

//   factory XFileJson.fromJson(Map<String, dynamic> json) =>
//       _$XFileJsonFromJson(json);
// }

// // create xfile json converter
// class XFileJsonConverter extends JsonConverter<XFile, Future<XFileJson>> {
//   const XFileJsonConverter();

//   @override
//   XFile fromJson(Future<XFileJson> json) {
//     late final XFile xFile;
//     json.then((value) => xFile = XFile(
//           json.path,
//           name: json.name,
//           mimeType: json.mimeType,
//           length: json.length,
//           bytes: json.bytes,
//           lastModified: json.lastModified,
//         ));
//     // final newXfile = XFile(
//     //   json.path,
//     //   name: json.name,
//     //   mimeType: json.mimeType,
//     //   length: json.length,
//     //   bytes: json.bytes,
//     //   lastModified: json.lastModified,
//     // );

//     return xFile;
//   }

//   @override
//   Future<XFileJson> toJson(XFile xFile) async {
//     final newXfileJson = XFileJson(
//       path: xFile.path,
//       mimeType: xFile.mimeType,
//       name: xFile.name,
//       length: await xFile.length(),
//       bytes: await xFile.readAsBytes(),
//       lastModified: await xFile.lastModified(),
//     );
//     return newXfileJson;
//   }
// }
