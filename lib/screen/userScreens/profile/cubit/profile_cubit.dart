import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model.dart';
import 'dart:convert' as convert;

import 'package:mosque/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  void resetValues() {
    imageCompress = null;
    linkProfileImg = null;
  }

  Future<void> updateUser(
      {required String nom,
      required String prenom,
      required String telephone,
      required String email,
      required String age,
      String? deleteOldImage}) async {
    emit(UpdateUserLoadingState());

    if (imageCompress != null) {
      await updateProfileImg(
        deleteOldImage: deleteOldImage,
      );
    }
    Map<String, dynamic> _model = {
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "telephone": telephone,
      "age": age,
      if (linkProfileImg != null) "photo": linkProfileImg
    };
    await Httplar.httpPut(path: UPDATEJOUEUR, data: _model).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        DataUserModel model = DataUserModel.fromJson(jsonResponse);

        print('badalt info user');
        emit(UpdateUserStateGood(model: model));
      } else {
        print(value.body);
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateUserStateBad());
    });
  }

  // !--------imagepicker with Compress
  File? imageCompress;
  Future<void> imagePickerProfile(ImageSource source) async {
    final ImagePicker _pickerProfile = ImagePicker();
    await _pickerProfile.pickImage(source: source).then((value) async {
      // imageProfile = value;
      await FlutterImageCompress.compressAndGetFile(
        File(value!.path).absolute.path,
        '${File(value.path).path}.jpg',
        quality: 10,
      ).then((value) {
        imageCompress = File(value!.path);
        emit(ImagePickerProfileUserStateGood());
      });
    }).catchError((e) {
      emit(ImagePickerProfileUserStateBad());
    });
  }

  String? linkProfileImg;
  Future<void> updateProfileImg({required String? deleteOldImage}) async {
    await deleteOldImageFirebase(deleteOldImage: deleteOldImage);
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCompress!.path).pathSegments.last}')
        .putFile(imageCompress!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkProfileImg = value;
        print(linkProfileImg);
        // emit(UploadProfileImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        emit(UploadProfileUserImgAndGetUrlStateBad());
      });
    });
  }

  Future<void> deleteOldImageFirebase({required String? deleteOldImage}) async {
    if (deleteOldImage != null) {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(deleteOldImage)
          .delete()
          .then((_) {
        print('Old image deleted successfully');
      }).catchError((error) {
        print('Failed to delete old image: $error');
      });
    }
  }
}
