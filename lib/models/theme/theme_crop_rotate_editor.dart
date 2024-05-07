import 'package:flutter/widgets.dart';

import 'theme_shared_values.dart';

/// The `CropRotateEditorTheme` class defines the theme for the crop and rotate editor in the image editor.
/// It includes properties such as colors for the app bar, background, crop corners, and more.
///
/// Usage:
///
/// ```dart
/// CropRotateEditorTheme cropRotateEditorTheme = CropRotateEditorTheme(
///   appBarBackgroundColor: Colors.black,
///   appBarForegroundColor: Colors.white,
///   background: Colors.grey,
///   cropCornerColor: Colors.blue,
///   cropRectType: InitCropRectType.circle,
/// );
/// ```
///
/// Properties:
///
/// - `appBarBackgroundColor`: Background color of the app bar in the crop and rotate editor.
///
/// - `appBarForegroundColor`: Foreground color (text and icons) of the app bar.
///
/// - `background`: Background color of the crop and rotate editor.
///
/// - `cropCornerColor`: Color of the crop corners.
///
/// - `cropRectType`: Type of the initial crop rectangle (e.g., `InitCropRectType.circle`, `InitCropRectType.imageRect`).
///
/// Example Usage:
///
/// ```dart
/// CropRotateEditorTheme cropRotateEditorTheme = CropRotateEditorTheme(
///   appBarBackgroundColor: Colors.black,
///   appBarForegroundColor: Colors.white,
///   background: Colors.grey,
///   cropCornerColor: Colors.blue,
///   cropRectType: InitCropRectType.circle,
/// );
///
/// Color appBarBackgroundColor = cropRotateEditorTheme.appBarBackgroundColor;
/// Color background = cropRotateEditorTheme.background;
/// // Access other theme properties...
/// ```
class CropRotateEditorTheme {
  /// Background color of the app bar in the crop and rotate editor.
  final Color appBarBackgroundColor;

  /// Foreground color (text and icons) of the app bar.
  final Color appBarForegroundColor;

  /// Background color of the bottom app bar.
  final Color bottomBarBackgroundColor;

  /// Foreground color (text and icons) of the bottom app bar.
  final Color bottomBarForegroundColor;

  /// Background color of the bottomSheet for aspect ratios.
  final Color aspectRatioSheetBackgroundColor;

  /// Foreground color of the bottomSheet for aspect ratios.
  final Color aspectRatioSheetForegroundColor;

  /// Background color of the crop and rotate editor.
  final Color background;

  /// Color of the crop corners.
  final Color cropCornerColor;

  /// Color from the helper lines when moving the image.
  final Color helperLineColor;

  /// This refers to the overlay area atop the image when the cropping area is smaller than the image.
  ///
  /// The opacity of this area is 0.84 when no interaction is active and 0.6 when an interaction is active.
  final Color cropOverlayColor;

  /// Background color for the bottombar when the editor use WhatsApp as theme
  /// and the designMode is set to Cupertino
  final Color whatsappCupertinoBottomBarColor;

  /// Creates an instance of the `CropRotateEditorTheme` class with the specified theme properties.
  const CropRotateEditorTheme({
    this.appBarBackgroundColor = imageEditorAppBarColor,
    this.appBarForegroundColor = const Color(0xFFE1E1E1),
    this.helperLineColor = const Color(0xFF000000),
    this.background = imageEditorBackgroundColor,
    this.cropCornerColor = imageEditorPrimaryColor,
    this.cropOverlayColor = const Color(0xFF000000),
    this.bottomBarBackgroundColor = imageEditorAppBarColor,
    this.bottomBarForegroundColor = const Color(0xFFE1E1E1),
    this.whatsappCupertinoBottomBarColor = const Color(0xFF303030),
    this.aspectRatioSheetBackgroundColor = const Color(0xFF303030),
    this.aspectRatioSheetForegroundColor = const Color(0xFFFAFAFA),
  });
}
