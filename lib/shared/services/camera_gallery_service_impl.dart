import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();
  
  @override
  Future<String?> selectPhoto() async {

    final XFile? photo = await _picker.pickImage( source: ImageSource.gallery );
    if ( photo == null ) return null;

    // print("Existe una nueva image ${ photo.path }");
    return photo.path;
    
  }

  @override
  Future<String?> takePhoto() async {
   
    final XFile? photo = await _picker.pickImage( source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear );
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