import 'editor_init_configs.dart';

/// Configuration class for initializing the paint editor.
///
/// This class extends [EditorInitConfigs] and adds specific parameters related to painting functionality.
class PaintEditorInitConfigs extends EditorInitConfigs {
  /// Creates a new instance of [PaintEditorInitConfigs].
  ///
  /// The [theme] parameter specifies the theme data for the editor.
  /// The [imageSize] parameter specifies the size of the image.
  /// The [paddingHelper] parameter specifies additional padding for the editor.
  /// The other parameters are inherited from [EditorInitConfigs].
  const PaintEditorInitConfigs({
    super.configs,
    super.onUpdateUI,
    super.transformConfigs,
    super.layers,
    super.mainImageSize,
    super.mainBodySize,
    super.appliedFilters,
    super.appliedBlurFactor,
    required super.theme,
  });
}
