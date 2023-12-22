// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  String? name;
  String? bucket;
  String? generation;
  String? metageneration;
  String? contentType;
  String? timeCreated;
  String? updated;
  String? storageClass;
  String? size;
  String? md5Hash;
  String? contentEncoding;
  String? contentDisposition;
  String? crc32C;
  String? etag;
  String? downloadTokens;

  ImageModel({
    this.name,
    this.bucket,
    this.generation,
    this.metageneration,
    this.contentType,
    this.timeCreated,
    this.updated,
    this.storageClass,
    this.size,
    this.md5Hash,
    this.contentEncoding,
    this.contentDisposition,
    this.crc32C,
    this.etag,
    this.downloadTokens,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    name: json["name"],
    bucket: json["bucket"],
    generation: json["generation"],
    metageneration: json["metageneration"],
    contentType: json["contentType"],
    timeCreated: json["timeCreated"],
    updated: json["updated"],
    storageClass: json["storageClass"],
    size: json["size"],
    md5Hash: json["md5Hash"],
    contentEncoding: json["contentEncoding"],
    contentDisposition: json["contentDisposition"],
    crc32C: json["crc32c"],
    etag: json["etag"],
    downloadTokens: json["downloadTokens"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "bucket": bucket,
    "generation": generation,
    "metageneration": metageneration,
    "contentType": contentType,
    "timeCreated": timeCreated,
    "updated": updated,
    "storageClass": storageClass,
    "size": size,
    "md5Hash": md5Hash,
    "contentEncoding": contentEncoding,
    "contentDisposition": contentDisposition,
    "crc32c": crc32C,
    "etag": etag,
    "downloadTokens": downloadTokens,
  };
}
