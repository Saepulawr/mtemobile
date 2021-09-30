import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtemobile/modules/input_barang_masuk/models/data_input_barang_masuk_model/data_input_barang_masuk_model.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:mtemobile/shared/utils/animated/animated_scrolling.dart';
import 'package:mtemobile/shared/utils/image_viewer/image_viewer.dart';
import 'package:mtemobile/shared/widgets/show_up_animation-2.0.0/show_up_animation.dart';

class InputBarangMasuk extends StatefulWidget {
  InputBarangMasuk({Key? key}) : super(key: key);

  @override
  _InputBarangMasukState createState() => _InputBarangMasukState();
}

class _InputBarangMasukState extends State<InputBarangMasuk> {
  DataInputBarangMasukModel _newData = DataInputBarangMasukModel();
  GlobalKey<ScaffoldState> _keyScafold = GlobalKey();
  ValueNotifier<List<String>> _pathImages = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: _keyScafold,
      backgroundColor: Themes.primary,
      appBar: AppBar(
        title: Text("Tambah data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Foto barang",
                style: Themes.title,
              ),
              ValueListenableBuilder<List<String>>(
                valueListenable: _pathImages,
                builder: (context, value, child) => Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: Wrap(
                    children: [
                      ...value.map((e) => _thumbnailImage(
                            path: e,
                            onTap: (path) {
                              Get.to(() => ImageViewer(
                                    imagesPath: _pathImages.value,
                                    backgroundColor: Themes.primary,
                                    initialIndex: _pathImages.value.indexOf(e),
                                    selectedIndicatorColor: Themes.secondary,
                                  ));
                            },
                            onTapRemove: (path) {
                              _pathImages.value = List.from(_pathImages.value)
                                ..remove(path);
                            },
                          )),
                      _pathImages.value.length >= 5
                          ? Container()
                          : _thumbnailAddImage()
                    ],
                  ),
                ),
              ),
              _input(
                  icon: Icons.person,
                  labeltext: "Dari",
                  hintText: "Masukan nama pemilik barang"),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheetImageSource() {
    _keyScafold.currentState!.showBottomSheet<void>(
      (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 0.0,
                color: Themes.primaryLight,
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Kamera",
                    style: Themes.title,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final ImagePicker _picker = ImagePicker();
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      _pathImages.value = List.from(_pathImages.value)
                        ..add(photo.path);
                    }
                  },
                ),
              ),
              Card(
                elevation: 0.0,
                color: Themes.primaryLight,
                child: ListTile(
                  leading: Icon(
                    Icons.collections,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Galeri",
                    style: Themes.title,
                  ),
                  onTap: () {},
                ),
              )
            ],
          ),
        );
      },
      backgroundColor: Themes.primaryLight,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.only(
            topLeft: Themes.radius16, topRight: Themes.radius16),
      ),
    );
  }

  Widget _thumbnailAddImage() {
    return Container(
      height: 100,
      width: 100,
      margin: EdgeInsets.all(8.0),
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Themes.primaryLight),
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                _pathImages.value.add(photo.path);
                _pathImages.notifyListeners();
              }
            },
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _thumbnailImage(
      {required String path,
      void Function(String path)? onTapRemove,
      void Function(String path)? onTap}) {
    return animatedScolling(
      direction: Direction.horizontal,
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            onTap: () {
              if (onTap != null) onTap(path);
            },
            child: Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Themes.primaryLight,
                image: DecorationImage(
                    image: FileImage(File(path)), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  if (onTapRemove != null) onTapRemove(path);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }

  Widget _input(
      {String hintText = "",
      required String labeltext,
      required IconData icon}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        labelStyle: TextStyle(color: Colors.white),
        labelText: labeltext,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _row(
      {required Widget icon, required String title, required Widget content}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Themes.padding8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 24, height: 24, alignment: Alignment.center, child: icon),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Themes.primaryFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                content
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key? key, required this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback? onTap;
  final double? width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
