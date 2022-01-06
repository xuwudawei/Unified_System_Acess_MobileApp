import 'dart:html';

class FaceImageModel {
  bool? isUploaded;
  bool? uploading;
  File? imageFile;
  String? imageUrl;

  FaceImageModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
