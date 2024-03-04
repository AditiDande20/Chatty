import 'dart:io';

import 'package:chatty/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/custom_colors.dart';

class UserImagePicker extends StatefulWidget {
  final String? imageUrl;
  final void Function(File pickedImage) onPickImage;
  const UserImagePicker({super.key, required this.onPickImage, this.imageUrl});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: CustomColors.backgroundColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: CustomColors.foregroundColor,
                    offset: const Offset(
                      7,
                      7,
                    ),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(
                      -7,
                      -7,
                    ))
              ]),
          child: CircleAvatar(
            radius: 60,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
            backgroundImage: (widget.imageUrl != null)
                ? NetworkImage(widget.imageUrl!) as ImageProvider
                : const AssetImage('assets/images/man.png'),
            // backgroundImage:
            //     widget.imageUrl != null && widget.imageUrl!.isNotEmpty
            //         ? NetworkImage(widget.imageUrl!)
            //         : const AssetImage('assets/images/man.png'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(
              Icons.image,
              size: 30,
            ),
            label: const Text(ConstantsData.addImage,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.baseColor,
                )))
      ],
    );
  }
}
