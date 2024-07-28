import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'dart:convert' as convert;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model.dart';
import 'package:mosque/model/section_model.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);
  void resetImageSection() {
    imageCompress = null;
    linkProfileImg = null;
    emit(ResetImageSectionState());
  }

  Future<void> getAllSection() async {
    List<SectionModel> sectionModel = [];
    emit(GetAllSectionLoading());
    await Httplar.httpget(path: GETALLSECTION).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        sectionModel =
            jsonResponse.map((e) => SectionModel.fromJson(e)).toList();
        emit(GetAllSectionStateGood(model: sectionModel));

        print(sectionModel.first.name);
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllSectionStateBad());
    });
  }

  Future<void> createSection({required Map<String, dynamic> data}) async {
    emit(CreateSectionLoading());
    if (imageCompress != null) {
      await updateSectionImg(deleteOldImage: null);
    }
    if (linkProfileImg != null) {
      data['photo'] = linkProfileImg;
    }
    Httplar.httpPost(path: CREATESECTION, data: data).then((value) {
      if (value.statusCode == 201) {
        emit(CreateSectionGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: errorModel));
      }
    }).catchError((e) {
      emit(CreateSectionBad());
    });
  }

  Future<void> deleteSection(
      {required String sectionId, required String mot_de_passe}) async {
    emit(DeleteSectionLoading());
    await Httplar.httpPost(
        path: DELETESECTION + sectionId,
        data: {"mot_de_passe": mot_de_passe}).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteSectionGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: errorModel));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteSectionBad());
    });
  }

  Future<void> updateSection({
    required String sectionId,
    required Map<String, dynamic> data,
    String? deleteOldImage,
  }) async {
    emit(UpdateSectionLoading());
    if (imageCompress != null) {
      await updateSectionImg(
        deleteOldImage: deleteOldImage,
      );
    }
    if (linkProfileImg != null) {
      data['photo'] = linkProfileImg;
    }
    await Httplar.httpPut(path: UPDATESECTION + sectionId, data: data)
        .then((value) {
      if (value.statusCode == 200) {
        emit(UpdateSectionGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: errorModel));
      }
    }).catchError((e) {
      emit(UpdateSectionBad());
    });
  }

  String? linkProfileImg;
  Future<void> updateSectionImg({required String? deleteOldImage}) async {
    await deleteOldImageFirebase(deleteOldImage: deleteOldImage);
    String fileName = path.basenameWithoutExtension(imageCompress!.path);
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('section/$fileName')
        .putFile(imageCompress!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkProfileImg = value;
        // emit(UploadProfileImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        emit(UploadSectionImgAndGetUrlStateBad());
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

  File? imageCompress;
  Future<void> imagePickerSection(ImageSource source) async {
    final ImagePicker pickerPhoto = ImagePicker();
    await pickerPhoto.pickImage(source: source).then((value) async {
      // imageProfile = value;
      await FlutterImageCompress.compressAndGetFile(
        File(value!.path).absolute.path,
        '${File(value.path).path}.jpg',
        quality: 90,
      ).then((value) {
        imageCompress = File(value!.path);
        emit(ImagePickerSectionStateGood());
      });
    }).catchError((e) {
      emit(ImagePickerSectionStateBad());
    });
  }
}
