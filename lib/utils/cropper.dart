import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class Cropper {
  static Future<File> cropSquareImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 20,
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          lockAspectRatio: true,
        )
      ],
    );
    return File(croppedImage!.path);
  }
}
