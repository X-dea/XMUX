import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xmux/redux/actions.dart';
import 'package:xmux/redux/state.dart';
import 'package:xmux/translations/translation.dart';

class AcademicPage extends StatelessWidget {
  Widget _buildPublicTalkList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.8,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Card(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Image.asset(
                      "res/initpage.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Container(
                      width: 230.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "A Career as Consulting Engineer in Building",
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Divider(),
                          Text("Bdbai Haotian"),
                          Text(
                            "9-10AM. 6th/Jun/2050",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            "A5 # G01",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: StoreConnector<MainAppState, VoidCallback>(
          converter: (store) => () => store.dispatch(OpenDrawerAction(true)),
          builder: (context, callback) =>
              IconButton(icon: Icon(Icons.view_list), onPressed: callback),
        ),
        title: Text(MainLocalizations.of(context).get("Academic")),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
        children: <Widget>[
          Row(children: <Widget>[
            Text(
              " " + MainLocalizations.of(context).get("Academic/Tools"),
              style: Theme.of(context).textTheme.title,
            ),
            FlatButton(
              child: Text("More"),
              onPressed: () =>
                  Navigator.of(context).pushNamed("/Academic/Tools/Details"),
            ),
          ]),
          Divider(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _ToolsButton(
                  icon: Image.asset("res/academic/wolfram.png"),
                  title: "Academic/Tools/WolframEngine/Title",
                  path: "/Academic/Tools/WolframEngine"),
              _ToolsButton(
                  icon: Image.asset("res/academic/geogebra.png"),
                  title: "Academic/Tools/GeoGebra/Title",
                  path: "/Academic/Tools/GeoGebra"),
              _ToolsButton(
                  icon: Image.asset("res/academic/gpa.png"),
                  title: "Academic/Tools/GPACalculator/Name",
                  path: "/Academic/Tools/GPACalculator"),
              _ToolsButton(
                  icon: Icon(
                    Icons.local_hospital,
                    size: 60.0,
                    color: Colors.red,
                  ),
                  title: "Academic/Tools/ExamResult/Title",
                  path: "/Academic/Tools/ExamResult"),
            ],
          ),
          Text(
            " " + MainLocalizations.of(context).get("Academic/PublicTalks"),
            style: Theme.of(context).textTheme.title,
          ),
          Divider(),
          _buildPublicTalkList(context),
        ],
      ),
    );
  }
}

class _ToolsButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final String path;

  _ToolsButton(
      {@required this.icon, @required this.title, @required this.path});

  @override
  Widget build(BuildContext context) => Container(
        height: 80.0,
        width: 80.0,
        margin: EdgeInsets.all(7.0),
        child: IconButton(
          icon: icon,
          onPressed: () => Navigator.of(context).pushNamed(path),
          tooltip: MainLocalizations.of(context).get(title),
          iconSize: 80.0,
        ),
      );
}
