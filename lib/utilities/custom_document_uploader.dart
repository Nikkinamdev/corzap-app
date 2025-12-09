// import 'dart:io';
// import 'dart:math' as math;
// import 'package:corezap_driver/utilities/app_buttons.dart';
// import 'package:corezap_driver/utilities/colors.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:corezap_driver/controller/document_upload_controller.dart';

// class CustomDocumentUploader extends StatefulWidget {
//   final String uploaderKey;
//   final String? uploadText;
//   final IconData uploadIcon;
//   final double height;
//   final double? width;
//   final Color borderColor;
//   final double borderWidth;
//   final Color backgroundColor;
//   final double borderRadius;
//   final bool isCircular;
//   final bool isRequired;

//   const CustomDocumentUploader({
//     super.key,
//     required this.uploaderKey,
//     this.uploadText,
//     this.uploadIcon = Icons.upload,
//     this.height = 200.0,
//     this.width,
//     this.borderColor = const Color(0xFF90A4AE),

//     this.borderWidth = 2.0,
//     this.backgroundColor = const Color(0xFFFAFAFA),
//     this.borderRadius = 8.0,
//     this.isCircular = false,
//     this.isRequired = false,
//   });

//   @override
//   CustomDocumentUploaderState createState() => CustomDocumentUploaderState();
// }

// class CustomDocumentUploaderState extends State<CustomDocumentUploader> {
//   final ImagePicker _picker = ImagePicker();

//   final DocumentUploadController uploadController =
//       Get.find<DocumentUploadController>();

//   // Future<void> _pickImage() async {
//   //   try {
//   //     final XFile? picked = await _picker.pickImage(
//   //       source: ImageSource.gallery,
//   //       imageQuality: 80,
//   //     );

//   //     if (picked != null) {
//   //       final file = File(picked.path);
//   //       uploadController.setImage(widget.uploaderKey, file);
//   //     }
//   //   } catch (e) {
//   //     debugPrint('Image picking failed: $e');
//   //     ScaffoldMessenger.of(
//   //       context,
//   //     ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
//   //   }
//   // }
//   // new
//   Future<void> _pickImage() async {
//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );

//       if (picked != null) {
//         final file = File(picked.path);
//         uploadController.setImage(widget.uploaderKey, file);
//       } else {
//         // If required and not selected
//         if (widget.isRequired) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('This document is required. Please upload it.'),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       debugPrint('Image picking failed: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
//     }
//   }

//   // validate
//   bool isValid() {
//     final File? image = uploadController.getImage(widget.uploaderKey);
//     if (widget.isRequired && image == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Please upload ${widget.uploadText ?? "this document"}',
//           ),
//         ),
//       );
//       return false;
//     }
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;

//     double effectiveWidth = widget.width ?? widget.height;
//     double effectiveHeight = widget.height;
//     double effectiveRadius = widget.borderRadius;

//     if (widget.isCircular) {
//       double side = math.min(effectiveWidth, effectiveHeight);
//       effectiveWidth = side;
//       effectiveHeight = side;
//       effectiveRadius = side / 2;
//     }

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: w * .03),
//       child: Obx(() {
//         final File? image = uploadController.getImage(widget.uploaderKey);

//         return SizedBox(
//           width: effectiveWidth,
//           height: effectiveHeight,
//           child: DottedBorder(
//             options: RoundedRectDottedBorderOptions(
//               radius: Radius.circular(effectiveRadius),
//               color: (widget.isRequired && image == null)
//                   ? Colors.red
//                   : widget.borderColor,
//               strokeWidth: widget.borderWidth,
//               dashPattern: const [6, 2],
//               padding: EdgeInsets.zero,
//             ),

//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.lightGray,
//                 borderRadius: BorderRadius.circular(effectiveRadius),
//               ),
//               child: image == null
//                   ? Center(
//                       child: AppButtons.solid(
//                         context: context,
//                         text: widget.uploadText ?? "Upload",
//                         onClicked: _pickImage,
//                         prefixIcon: Icon(
//                           Icons.file_upload_outlined,
//                           color: AppColors.white,
//                           size: w * .05,
//                         ),
//                         width: w * .3,
//                         height: w * .1,
//                         backgroundColor: AppColors.black,
//                         textColor: AppColors.white,
//                         fontSize: w * .04,
//                         radius: w * .1,
//                         fontWeight: FontWeight.w500,
//                         padding: EdgeInsets.zero,
//                       ),
//                     )
//                   : Stack(
//                       children: [
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               effectiveRadius,
//                             ),
//                             child: Image.file(
//                               image,
//                               width: effectiveWidth,
//                               height: effectiveHeight,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: GestureDetector(
//                             onTap: () {
//                               uploadController.removeImage(widget.uploaderKey);
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(w * .01),
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.6),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.close,
//                                 color: AppColors.white,
//                                 size: w * .04,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//new
import 'dart:io';
import 'dart:math' as math;
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:corezap_driver/controller/document_upload_controller.dart';

class CustomDocumentUploader extends StatefulWidget {
  final String uploaderKey;
  final String? uploadText;
  final IconData uploadIcon;
  final double height;
  final double? width;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final double borderRadius;
  final bool isCircular;
  final bool isRequired;

  const CustomDocumentUploader({
    super.key,
    required this.uploaderKey,
    this.uploadText,
    this.uploadIcon = Icons.upload,
    this.height = 200.0,
    this.width,
    this.borderColor = const Color(0xFF90A4AE),
    this.borderWidth = 2.0,
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.borderRadius = 8.0,
    this.isCircular = false,
    this.isRequired = false,
  });

  @override
  CustomDocumentUploaderState createState() => CustomDocumentUploaderState();
}

class CustomDocumentUploaderState extends State<CustomDocumentUploader> {
  final ImagePicker _picker = ImagePicker();
  final DocumentUploadController uploadController =
      Get.find<DocumentUploadController>();

  Future<void> _pickImage() async {
    print(
      "=== PICK IMAGE DEBUG for key: '${widget.uploaderKey}' ===",
    ); // Key debug
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked != null) {
        final file = File(picked.path);
        print("Picked file path: ${file.path}"); // Path debug
        uploadController.setImage(widget.uploaderKey, file);
        print(
          "Set image complete for '${widget.uploaderKey}'",
        ); // Set complete debug
      } else {
        print("No file picked for '${widget.uploaderKey}'"); // No pick debug
        if (widget.isRequired) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This document is required. Please upload it.'),
            ),
          );
        }
      }
    } catch (e) {
      print(
        'Image picking failed for "${widget.uploaderKey}": $e',
      ); // FIXED: Quotes + key in error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
    }
    print("=== END PICK IMAGE DEBUG ===");
  }

  // Updated isValid: existsSync + debug print
  bool isValid() {
    final File? image = uploadController.getImage(widget.uploaderKey);
    final bool hasPath = image != null && image.path.isNotEmpty;
    final bool fileExists = hasPath && image.existsSync();
    print(
      "State isValid for '${widget.uploaderKey}': hasPath=$hasPath, exists=$fileExists (path: ${image?.path ?? 'NULL'})",
    );
    if (!hasPath && widget.isRequired) {
      // Snackbar only if no path
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please upload ${widget.uploadText ?? "this document"}',
          ),
        ),
      );
    }
    return hasPath; // CHANGE: Return hasPath (loose validation)
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    double effectiveWidth = widget.width ?? widget.height;
    double effectiveHeight = widget.height;
    double effectiveRadius = widget.borderRadius;

    if (widget.isCircular) {
      double side = math.min(effectiveWidth, effectiveHeight);
      effectiveWidth = side;
      effectiveHeight = side;
      effectiveRadius = side / 2;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * .03),
      child: Obx(() {
        final File? image = uploadController.getImage(widget.uploaderKey);
        print(
          "Build Obx for '${widget.uploaderKey}': Image path = ${image?.path ?? 'NULL'}",
        ); // Obx debug

        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(effectiveRadius),
              color: (widget.isRequired && image == null)
                  ? Colors.red
                  : widget.borderColor,
              strokeWidth: widget.borderWidth,
              dashPattern: const [6, 2],
              padding: EdgeInsets.zero,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(effectiveRadius),
              ),
              child: image == null
                  ? Center(
                      child: AppButtons.solid(
                        context: context,
                        text: widget.uploadText ?? "Upload",
                        onClicked: _pickImage,
                        prefixIcon: Icon(
                          Icons.file_upload_outlined,
                          color: AppColors.white,
                          size: w * .05,
                        ),
                        width: w * .3,
                        height: w * .1,
                        backgroundColor: AppColors.black,
                        textColor: AppColors.white,
                        fontSize: w * .04,
                        radius: w * .1,
                        fontWeight: FontWeight.w500,
                        padding: EdgeInsets.zero,
                      ),
                    )
                  : Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              effectiveRadius,
                            ),
                            child: Image.file(
                              image,
                              width: effectiveWidth,
                              height: effectiveHeight,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print(
                                  "Image load error for '${widget.uploaderKey}': $error",
                                );
                                return Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: w * .1,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              print(
                                "Removing image for '${widget.uploaderKey}'",
                              );
                              uploadController.removeImage(
                                widget.uploaderKey,
                              ); // Controller call
                            },
                            child: Container(
                              padding: EdgeInsets.all(w * .01),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: AppColors.white,
                                size: w * .04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      }),
    );
  }
}
