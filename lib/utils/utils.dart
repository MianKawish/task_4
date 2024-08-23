import 'package:image_picker/image_picker.dart';

class Utils {
  final imagePicker = ImagePicker();

  Future<XFile?> cameraCapture() async {
    final XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    return file;
  }

  Future<XFile?> pickImageFromGallery() async {
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }

  Future<XFile?> pickVideoFromGallery() async {
    final XFile? videoFile =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    return videoFile;
  }

  Future<XFile?> recordVideo() async {
    final XFile? videoFile =
        await imagePicker.pickVideo(source: ImageSource.camera);
    return videoFile;
  }
}
