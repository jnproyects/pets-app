import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();

  //TODO: manejar excepciones
  
  /// For example, if you encounter the error message “PlatformException(permission_denied, photo library access not granted, null),” you can prompt the user to grant the necessary permissions to access their photo library.

  @override
  Future<String?> selectPhoto() async {

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery, 
      maxWidth: 1920,
      maxHeight: 1280,
      imageQuality: 80
    );
    if ( photo == null ) return null;

    // print("Existe una nueva image ${ photo.path }");
    return photo.path;
    
  }

  @override
  Future<String?> takePhoto() async {
   
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera, 
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: 1920,
      maxHeight: 1280,
      imageQuality: 80
    );
    if ( photo == null ) return null;

    // print("Existe una nueva image ${ photo.path }");
    return photo.path;

  }
  
  @override
  Future<List<String>?> selectMultiplePhotos() async {

    final List<XFile> images = await _picker.pickMultiImage();
    
    if ( images.isEmpty ) return null;
    
    final List<String> imagesPath = images.map(( image ) => image.path ).toList();
    
    return imagesPath;

  }

}