import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import 'set_wardrobe_height_widget.dart' show SetWardrobeHeightWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetWardrobeHeightModel extends FlutterFlowModel<SetWardrobeHeightWidget> {
  ///  Local state fields for this page.

  bool adjusting = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - receiveData] action in Button widget.
  String? adjustReturn;
  // Stores action output result for [Custom Action - getAdjustStatus] action in Button widget.
  String? adjustStatus;
  // State field(s) for Slider widget.
  double? sliderValue;
  // Stores action output result for [Custom Action - receiveData] action in Button widget.
  String? confirmReturn;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
