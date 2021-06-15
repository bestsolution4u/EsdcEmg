import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/bloc/vpn/bloc.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VPNBloc extends Bloc<VPNEvent, VPNState> {
  VPNBloc() : super(VPNLoadingState());

  @override
  Stream<VPNState> mapEventToState(VPNEvent event) async* {
    if (event is VPNLoadEvent) {
      yield* _mapVPNLoadEventToState();
    }
  }

  Stream<VPNState> _mapVPNLoadEventToState() async* {
    List<VPNStatusModel> status = await Api.getVPNStatus();
    List<String> values = status.map((e) => e.toString()).toList();
    DateTime updatedAt = DateTime.now();
    PreferenceHelper.setStringList(PrefParams.VPN_STATUS, values);
    PreferenceHelper.setDate(PrefParams.VPN_UPDATED_AT, updatedAt);
    yield VPNLoadingState();
    yield VPNLoadedState(updatedAt: updatedAt, status: status);
  }
}