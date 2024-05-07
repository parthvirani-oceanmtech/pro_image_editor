import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/theme/theme.dart';

class CropCornerPainter extends CustomPainter {
  final Rect cropRect;
  final Rect viewRect;
  final Size screenSize;
  final ImageEditorTheme imageEditorTheme;
  final bool interactionActive;
  final bool drawCircle;
  final Offset offset;
  final double opacity;

  final double cornerLength;
  double cornerWidth = 6;

  double helperLineWidth = 0.5;

  final double scaleFactor;
  final double rotationScaleFactor;

  double get _cropOffsetLeft => cropRect.left;
  double get _cropOffsetRight => cropRect.right;
  double get _cropOffsetTop => cropRect.top;
  double get _cropOffsetBottom => cropRect.bottom;

  CropCornerPainter({
    required this.drawCircle,
    required this.offset,
    required this.cropRect,
    required this.opacity,
    required this.viewRect,
    required this.screenSize,
    required this.scaleFactor,
    required this.imageEditorTheme,
    required this.interactionActive,
    required this.cornerLength,
    required this.rotationScaleFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isInfinite) return;
    _drawDarkenOutside(canvas: canvas, size: size);
    if (interactionActive) _drawHelperAreas(canvas: canvas, size: size);
    _drawCorners(canvas: canvas, size: size);
  }

  void _drawDarkenOutside({
    required Canvas canvas,
    required Size size,
  }) {
    /// Draw outline darken layers
    double cropWidth = _cropOffsetRight - _cropOffsetLeft;
    double cropHeight = _cropOffsetBottom - _cropOffsetTop;

    Path path = Path();

    /// Filltype "evenOdd" is important for the canvas web renderer
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromCenter(
      center: Offset(
        size.width / 2 + offset.dx * scaleFactor,
        size.height / 2 + offset.dy * scaleFactor,
      ),
      width: size.width * scaleFactor,
      height: size.height * scaleFactor,
    ));
    if (drawCircle) {
      /// Create a path for the current rectangle
      Path circlePath = Path()
        ..addOval(
          Rect.fromCenter(
            center: Offset(
              cropWidth / 2 + _cropOffsetLeft,
              cropHeight / 2 + _cropOffsetTop,
            ),
            width: cropWidth,
            height: cropHeight,
          ),
        );

      /// Subtract the area of the current rectangle from the path for the entire canvas
      path = Path.combine(PathOperation.difference, path, circlePath);
    } else {
      /// Create a path for the current rectangle
      Path rectPath = Path()
        ..addRect(
          Rect.fromCenter(
            center: Offset(
              cropWidth / 2 + _cropOffsetLeft,
              cropHeight / 2 + _cropOffsetTop,
            ),
            width: cropWidth,
            height: cropHeight,
          ),
        );

      /// Subtract the area of the current rectangle from the path for the entire canvas
      path = Path.combine(PathOperation.difference, path, rectPath);
    }

    Color backgroundColor = imageEditorTheme.cropRotateEditor.cropOverlayColor;

    /// Draw the darkened area
    canvas.drawPath(
      path,
      Paint()
        ..color = interactionActive
            ? backgroundColor.withOpacity(
                (0.6 + 0.4 * (1 - opacity)).clamp(0, 1),
              )
            : backgroundColor.withOpacity(
                (0.84 + 0.16 * (1 - opacity)).clamp(0, 1),
              )
        ..style = PaintingStyle.fill,
    );
  }

  void _drawCorners({
    required Canvas canvas,
    required Size size,
  }) {
    Path path = Path();

    double width = cornerWidth / rotationScaleFactor;
    if (!drawCircle) {
      double length = cornerLength / rotationScaleFactor;

      /// Top-Left
      path.addRect(
          Rect.fromLTWH(_cropOffsetLeft, _cropOffsetTop, length, width));
      path.addRect(
          Rect.fromLTWH(_cropOffsetLeft, _cropOffsetTop, width, length));

      /// Top-Right
      path.addRect(Rect.fromLTWH(
          _cropOffsetRight - length, _cropOffsetTop, length, width));
      path.addRect(Rect.fromLTWH(
          _cropOffsetRight - width, _cropOffsetTop, width, length));

      /// Bottom-Left
      path.addRect(Rect.fromLTWH(
          0 + _cropOffsetLeft, _cropOffsetBottom - width, length, width));
      path.addRect(Rect.fromLTWH(
          0 + _cropOffsetLeft, _cropOffsetBottom - length, width, length));

      /// Bottom-Right
      path.addRect(Rect.fromLTWH(
          _cropOffsetRight - length, _cropOffsetBottom - width, length, width));
      path.addRect(Rect.fromLTWH(
          _cropOffsetRight - width, _cropOffsetBottom - length, width, length));

      canvas.drawPath(
        path,
        Paint()
          ..color = imageEditorTheme.cropRotateEditor.cropCornerColor
              .withOpacity(opacity)
          ..style = PaintingStyle.fill,
      );
    } else {
      double calculateAngleFromArcLength(
          double circumference, double arcLength) {
        if (circumference <= 0 || arcLength <= 0) {
          throw ArgumentError(
              "Circumference and arc length must be positive values.");
        }
        return circumference / 360 * arcLength * pi / 180;
      }

      double angleRadians =
          calculateAngleFromArcLength(cropRect.width, width * 2);

      /// Top
      path.addArc(
        Rect.fromCenter(
            center: cropRect.center,
            width: cropRect.width,
            height: cropRect.height),
        3 * pi / 2 - angleRadians / 2,
        angleRadians,
      );

      /// Left
      path.addArc(
        Rect.fromCenter(
            center: cropRect.center,
            width: cropRect.width,
            height: cropRect.height),
        pi - angleRadians / 2,
        angleRadians,
      );

      /// Right
      path.addArc(
        Rect.fromCenter(
            center: cropRect.center,
            width: cropRect.width,
            height: cropRect.height),
        pi / 2 - angleRadians / 2,
        angleRadians,
      );

      /// Right
      path.addArc(
        Rect.fromCenter(
            center: cropRect.center,
            width: cropRect.width,
            height: cropRect.height),
        -angleRadians / 2,
        angleRadians,
      );

      canvas.drawPath(
        path,
        Paint()
          ..color = imageEditorTheme.cropRotateEditor.cropCornerColor
              .withOpacity(opacity)
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      );
    }
  }

  void _drawHelperAreas({
    required Canvas canvas,
    required Size size,
  }) {
    Path path = Path();

    double cropWidth = _cropOffsetRight - _cropOffsetLeft;
    double cropHeight = _cropOffsetBottom - _cropOffsetTop;

    double cropAreaSpaceW = cropWidth / 3;
    double cropAreaSpaceH = cropHeight / 3;

    /// Calculation is important for the round-cropper
    double lineWidth = !drawCircle
        ? cropWidth
        : sqrt(pow(cropWidth, 2) - pow(cropAreaSpaceW, 2));
    double lineHeight = !drawCircle
        ? cropHeight
        : sqrt(pow(cropHeight, 2) - pow(cropAreaSpaceH, 2));

    double gapW = (cropWidth - lineWidth) / 2;
    double gapH = (cropHeight - lineHeight) / 2;

    for (var i = 1; i < 3; i++) {
      path.addRect(
        Rect.fromLTWH(
          cropAreaSpaceW * i + _cropOffsetLeft,
          gapH + _cropOffsetTop,
          helperLineWidth,
          lineHeight,
        ),
      );

      path.addRect(
        Rect.fromLTWH(
          gapW + _cropOffsetLeft,
          cropAreaSpaceH * i + _cropOffsetTop,
          lineWidth,
          helperLineWidth,
        ),
      );
    }

    final cornerPaint = Paint()
      ..color =
          imageEditorTheme.cropRotateEditor.helperLineColor.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! CropCornerPainter ||
        oldDelegate.cropRect != cropRect ||
        oldDelegate.viewRect != viewRect ||
        oldDelegate.rotationScaleFactor != rotationScaleFactor;
  }
}
