import 'dart:io';
import 'package:flutter/material.dart';
import 'helper/show_picker_option.dart';

class CustomImagePicker extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final bool showBorder;
  final IconData icon;
  final File? initialImage;
  final Function(File image)? onImageSelected;

  const CustomImagePicker({
    super.key,
    this.width = 120,
    this.height = 120,
    this.radius = 60,
    this.showBorder = true,
    this.icon = Icons.camera_alt,
    this.initialImage,
    this.onImageSelected,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.initialImage;
  }

  void _openPicker() {
    ShowPickerOption.show(
      context: context,
      onImageSelected: (image) {
        setState(() {
          _image = image;
        });

        if (widget.onImageSelected != null) {
          widget.onImageSelected!(image);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPicker,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.showBorder
              ? Border.all(color: Colors.grey.shade400, width: 2)
              : null,
          color: Colors.grey.shade200,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: _image != null
              ? Image.file(
            _image!,
            fit: BoxFit.cover,
          )
              : Icon(
            widget.icon,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}