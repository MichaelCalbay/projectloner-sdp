import 'package:image_picker/image_picker.dart';
import 'package:projectloner/models/models.dart';

abstract class BaseStorageRepo {
  Future<void> uploadImage(LonerUser user, XFile image);
  Future<String> getDownloadUrl(LonerUser user, String imageName);
}
