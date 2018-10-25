part of 'reducer.dart';

final Reducer<AuthState> authReducers = combineReducers([
  new TypedReducer<AuthState, LoginAction>(_loginReducer),
  new TypedReducer<AuthState, UpdateEPaymentPasswordAction>(
      _updateEPaymentPasswordReducer),
]);

AuthState _loginReducer(AuthState state, LoginAction action) => state.copyWith(
    campusID: action.auth.campusID,
    campusIDPassword: action.auth.campusIDPassword,
    moodleKey: action.moodleKey);

AuthState _updateEPaymentPasswordReducer(
        AuthState state, UpdateEPaymentPasswordAction action) =>
    state.copyWith(ePaymentPassword: action.ePaymentPassword);