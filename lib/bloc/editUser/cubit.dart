
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

//import '../../pages/editUser.dart';

part 'states.dart';
class ImagePickerCubit extends Cubit<ImagePickerStates>
{
  ImagePickerCubit(): super(ImagePickerInitialState());

  static ImagePickerCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();

  XFile? image;
  File? fileImage;
   takePhoto(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
     var file = File(pickedFile.path);
    fileImage = file;
    image=pickedFile;
    emit(ImagePickerChangeState());
  }
  }

  //PickedFile? get pickedImage => image != null ? PickedFile(image!.path) : null;

}