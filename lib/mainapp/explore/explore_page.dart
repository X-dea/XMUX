import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/mainapp/explore/chat_room_page.dart';
import 'package:xmux/mainapp/explore/flea_market/flea_market_page.dart';
import 'package:xmux/redux/redux.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlareActor('res/animations/stars.flr',
              alignment: Alignment.center, fit: BoxFit.fill, animation: 'idle'),
          Positioned(
            left: 20.0,
            top: 50.0,
            child: Text(
              i18n('Explore', context),
              style: TextStyle(fontSize: 50.0, color: Colors.white70),
            ),
          ),
          ListView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.8),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.find_in_page, color: Colors.white70),
                title: Text(
                  i18n('lostandfound', context),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, "/Explore/LostAndFound"),
              ),
              ListTile(
                leading: Icon(Icons.chat, color: Colors.white70),
                title: Text(
                  i18n('About/Feedback', context),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white),
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (_) => new GlobalChatroomPage())),
              ),
              ListTile(
                leading: Icon(Icons.store, color: Colors.white70),
                title: Text(
                  i18n('FleaMarket', context),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white),
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (_) => new FleaMarketPage())),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: StoreConnector<MainAppState, bool>(
        converter: (s) => s.state.settingState.enableFunctionsUnderDev,
        builder: (_, v) => (v == true)
            ? FloatingActionButton(
                child: Icon(Icons.android),
                onPressed: () =>
                    showDialog(context: context, builder: (_) => xiA.page),
              )
            : Container(),
      ),
    );
  }
}
