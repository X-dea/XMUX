import 'package:connectivity/connectivity.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/modules/xmux_api/xmux_api_v2.dart';

part 'xmux_api_actions.dart';

abstract class MainAppAction {
  get needSave => true;

  get sync => false;

  toString() => "MainAppAction: ${this.runtimeType}";
}

class InitAction extends MainAppAction {
  get needSave => false;
  final Map<String, dynamic> initMap;

  InitAction(this.initMap);
}

class LoginAction extends MainAppAction {
  get sync => true;
  final String uid, password, moodleKey;

  LoginAction(this.uid, this.password, this.moodleKey);
}

class LogoutAction extends MainAppAction {
  get sync => true;
}

class OpenDrawerAction extends MainAppAction {
  get needSave => false;
  final bool drawerIsOpen;

  OpenDrawerAction(this.drawerIsOpen);
}

class ChangeConnectivityAction extends MainAppAction {
  get needSave => false;
  final ConnectivityResult connectivityResult;

  ChangeConnectivityAction(this.connectivityResult);
}

class EnableFunctionsUnderDevAction extends MainAppAction {
  final bool enableFunctionsUnderDev;

  EnableFunctionsUnderDevAction(this.enableFunctionsUnderDev);
}

class UpdateNewsAction extends MainAppAction {
  get needSave => false;
  final List news;

  UpdateNewsAction(this.news);
}

class UpdateAnnouncementAction extends MainAppAction {
  get needSave => false;
  final List announcements;

  UpdateAnnouncementAction(this.announcements);
}

class UpdateEPaymentPasswordAction extends MainAppAction {
  final String ePaymentPassword;

  UpdateEPaymentPasswordAction(this.ePaymentPassword);
}

class UpdateACAction extends MainAppAction {
  final Map<String, dynamic> acMap;

  UpdateACAction(this.acMap);
}

class UpdateAssignmentsAction extends MainAppAction {
  final List assignments;

  UpdateAssignmentsAction(this.assignments);
}