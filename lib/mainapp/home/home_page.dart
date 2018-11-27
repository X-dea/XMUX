import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/mainapp/home/announcements.dart';
import 'package:xmux/mainapp/home/home_slider.dart';
import 'package:xmux/redux/redux.dart';
import 'package:xmux/translations/translation.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(xmuxApi.convertAvatarUrl(
                  firebaseUser?.photoUrl, store.state.authState.moodleKey)),
            ),
            onPressed: () => store.dispatch(OpenDrawerAction(true)),
          ),
          title: Text(MainLocalizations.of(context).get("Home")),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            var newsAction = UpdateHomepageNewsAction();
            var announcementsAction = UpdateHomepageAnnouncementsAction();
            store.dispatch(newsAction);
            store.dispatch(announcementsAction);
            await newsAction.listener;
            await announcementsAction.listener;
          },
          child: ListView(
            children: <Widget>[
              // Slider
              Container(
                child: HomeSlider(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 18 * 9,
              ),

              // Announcements (if have)
              StoreConnector<MainAppState, List>(
                converter: (store) => store.state.uiState.announcements,
                builder: (_, announcements) => HomeAnnouncements(announcements),
              ),
            ],
          ),
        ),
      );
}
