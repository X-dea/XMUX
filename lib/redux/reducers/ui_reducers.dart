part of 'reducer.dart';

final Reducer<UIState> uiReducers = combineReducers([
  TypedReducer<UIState, OpenDrawerAction>(_openDrawerReducer),
  new TypedReducer<UIState, UpdateNewsAction>(_updateNewsReducer),
  new TypedReducer<UIState, UpdateAnnouncementAction>(
      _updateAnnouncementsReducer),
]);

UIState _openDrawerReducer(UIState state, OpenDrawerAction action) =>
    state.copyWith(drawerIsOpen: action.drawerIsOpen);

UIState _updateNewsReducer(UIState state, UpdateNewsAction action) =>
    state.copyWith(news: action.news);

UIState _updateAnnouncementsReducer(
        UIState state, UpdateAnnouncementAction action) =>
    state.copyWith(announcements: action.announcements);
