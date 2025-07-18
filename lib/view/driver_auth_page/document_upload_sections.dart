import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

import 'dart:io';

class DocumentUploadSections extends StatefulWidget {
  final String title;
  final String hintText;
  final String formatNote;
  final String iconPath;
  final Function(File) onFilePicked;

  const DocumentUploadSections({
    super.key,
    required this.title,
    required this.hintText,
    required this.formatNote,
    required this.iconPath,
    required this.onFilePicked,
  });

  @override
  State<DocumentUploadSections> createState() => _DocumentUploadSectionsState();
}

class _DocumentUploadSectionsState extends State<DocumentUploadSections> {
  File? pickedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      setState(() {
        pickedFile = file;
      });
      widget.onFilePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, // replace with your AppColors.appWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // replace with your color,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
            ), // replace with your AppTextStyle.small14SizeText,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _pickFile,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              color: Colors.grey, // replace with your AppColors.appGrayColoD42,
              strokeWidth: 2,
              dashPattern: [6, 4],
              child: Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                child:
                    pickedFile == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(widget.iconPath),
                            const SizedBox(height: 8),
                            Text(
                              widget.hintText,
                              style: TextStyle(fontSize: 14), // your style
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.formatNote,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ), // your style
                            ),
                          ],
                        )
                        : Center(
                          child: Text(
                            pickedFile!.path.split('/').last,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
