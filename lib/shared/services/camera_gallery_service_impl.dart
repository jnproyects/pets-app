import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();
  
  /// For example, if you encounter the error message “PlatformException(permission_denied, photo library access not granted, null),” you can prompt the user to grant the necessary permissions to access their photo library.
  /// Also, make sure you are handling the PermissionDeniedException, PickImageException correctly in your code.

  @override
  Future<String?> selectPhoto() async {

    try {

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery, 
        maxWidth: 1920,
        maxHeight: 1280,
        imageQuality: 80
      );
      if ( photo == null ) return null;
      return photo.path;

    } catch (e) {
      throw 'Pick image error: $e';
    }
    
  }

  @override
  Future<String?> takePhoto() async {
   
    try {
      
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, 
        preferredCameraDevice: CameraDevice.rear,
        maxWidth: 1920,
        maxHeight: 1280,
        imageQuality: 80
      );
      if ( photo == null ) return null;
      return photo.path;

    } catch (e) {
      throw 'Pick image error: $e';
    }

  }
  
  @override
  Future<List<String>?> selectMultiplePhotos() async {

    final List<XFile> images = await _picker.pickMultiImage();
    
    if ( images.isEmpty ) return null;
    
    final List<String> imagesPath = images.map(( image ) => image.path ).toList();
    
    return imagesPath;

  }

}