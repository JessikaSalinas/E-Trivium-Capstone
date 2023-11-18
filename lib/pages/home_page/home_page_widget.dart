import '/backend/schema/structs/index.dart';
import '/components/battery_charge_indicator_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
    this.deviceName,
    this.deviceId,
    this.hasWriteCharacteristic,
    this.deviceRssi,
  }) : super(key: key);

  final String? deviceName;
  final String? deviceId;
  final bool? hasWriteCharacteristic;
  final int? deviceRssi;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.dark);
      setState(() {
        _model.batteryCharge = 0;
      });
      _model.gotDataTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 10000),
        callback: (timer) async {
          _model.gotDataStr = await actions.receiveData(
            BTDeviceStruct(
              name: widget.deviceName,
              id: widget.deviceId,
              rssi: widget.deviceRssi,
            ),
          );
          _model.gotDataInt = await actions.convertStringToInt(
            _model.gotDataStr!,
          );
          setState(() {
            _model.batteryCharge = _model.gotDataInt;
          });
        },
        startImmediately: true,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              expandedHeight: 80.0,
              pinned: false,
              floating: false,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/E-Trivium_Logo_Orange.png',
                        width: 32.0,
                        height: 32.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'E-Trivium',
                        style:
                            FlutterFlowTheme.of(context).displayMedium.override(
                                  fontFamily: 'Outfit',
                                  fontSize: 28.0,
                                ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(1.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: wrapWithModel(
                            model: _model.batteryChargeIndicatorModel,
                            updateCallback: () => setState(() {}),
                            child: BatteryChargeIndicatorWidget(
                              charge: _model.batteryCharge!,
                              color: valueOrDefault<Color>(
                                () {
                                  if (_model.batteryCharge! > 50) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else if (_model.batteryCharge! > 25) {
                                    return FlutterFlowTheme.of(context).warning;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                FlutterFlowTheme.of(context).accent4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).secondaryBackground,
                      FlutterFlowTheme.of(context).accent1
                    ],
                    stops: [0.4, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'HealthLeafSettings',
                            queryParameters: {
                              'clothing': serializeParam(
                                'Gray Shirt',
                                ParamType.String,
                              ),
                              'deviceName': serializeParam(
                                widget.deviceName,
                                ParamType.String,
                              ),
                              'deviceId': serializeParam(
                                widget.deviceId,
                                ParamType.String,
                              ),
                              'deviceRssi': serializeParam(
                                widget.deviceRssi,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'Health',
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'SOSLeafSettings',
                            queryParameters: {
                              'clothing': serializeParam(
                                'Gray Shirt',
                                ParamType.String,
                              ),
                              'deviceName': serializeParam(
                                widget.deviceName,
                                ParamType.String,
                              ),
                              'deviceId': serializeParam(
                                widget.deviceId,
                                ParamType.String,
                              ),
                              'deviceRssi': serializeParam(
                                widget.deviceRssi,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'SOS',
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'LightLeafSettings',
                            queryParameters: {
                              'clothing': serializeParam(
                                'Gray Shirt',
                                ParamType.String,
                              ),
                              'deviceName': serializeParam(
                                widget.deviceName,
                                ParamType.String,
                              ),
                              'deviceId': serializeParam(
                                widget.deviceId,
                                ParamType.String,
                              ),
                              'deviceRssi': serializeParam(
                                widget.deviceRssi,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'Lights',
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.00, 1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 28.0, 28.0),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20.0,
                            borderWidth: 2.0,
                            buttonSize: 60.0,
                            fillColor: FlutterFlowTheme.of(context).accent1,
                            icon: Icon(
                              Icons.message_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(
                                'ChatPage',
                                queryParameters: {
                                  'deviceName': serializeParam(
                                    widget.deviceName,
                                    ParamType.String,
                                  ),
                                  'deviceId': serializeParam(
                                    widget.deviceId,
                                    ParamType.String,
                                  ),
                                  'hasWriteCharacteristic': serializeParam(
                                    widget.hasWriteCharacteristic,
                                    ParamType.bool,
                                  ),
                                  'deviceRssi': serializeParam(
                                    widget.deviceRssi,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}