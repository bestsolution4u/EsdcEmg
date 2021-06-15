import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VPNState {}

class VPNLoadingState extends VPNState {}

class VPNLoadedState extends VPNState {
  final DateTime updatedAt;
  final List<VPNStatusModel> status;

  VPNLoadedState({this.updatedAt, this.status});
}