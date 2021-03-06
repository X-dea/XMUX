import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:xmus_client/generated/user.pb.dart';
import 'package:xmux/components/page_routes.dart';
import 'package:xmux/globals.dart';

import 'item_edit_page.dart';
import 'model.dart';

part 'comment.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;

  /// The name and photoUrl to reduce API call frequency.
  final String name, photoUrl;

  ItemDetailPage(this.item, this.name, this.photoUrl);

  List<Widget> _buildDetails(BuildContext context) {
    return <Widget>[
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: photoUrl != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(moodleApi.withToken(photoUrl)),
                  )
                : SpinKitPulse(color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                name != null
                    ? Text(name, style: Theme.of(context).textTheme.subtitle1)
                    : Text('...'),
                Text(
                  '${DateFormat.yMd(Localizations.localeOf(context).languageCode).format(item.timestamp)} ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(item.timestamp)}',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              '${item.price.currencies} ${item.price.value.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
        child: Divider(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Text(
          item.name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Text(
          item.description,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    ];
  }

  List<Widget> _buildComments(BuildContext context) {
    return <Widget>[
      Padding(padding: const EdgeInsets.all(8)),
      Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        elevation: 0,
        shape: RoundedRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      i18n('FleaMarket/Details/Comments', context),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => _CommentDialog(item.key)),
                    tooltip: i18n('FleaMarket/Details/Comments/Add', context),
                  )
                ],
              ),
            ),
            Divider(),
            FirebaseAnimatedList(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              query: FirebaseDatabase.instance
                  .reference()
                  .child('flea_market/${item.key}/comments'),
              itemBuilder: (ctx, _, __, index) => _CommentCard.fromSnapshot(_),
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Build sliver app bar.
          SliverAppBar(
            title: Text(i18n('FleaMarket/Details', context)),
            backgroundColor: Colors.deepOrange,
            expandedHeight: 200,
            pinned: true,
            actions: <Widget>[
              // Edit button if isOwner.
              item.from.toLowerCase() == FirebaseAuth.instance.currentUser.uid
                  ? IconButton(
                      icon: const Icon(Icons.create),
                      tooltip: i18n('FleaMarket/Edit', context),
                      onPressed: () async {
                        var res = await Navigator.of(context)
                            .push<ItemEditResult>(
                                FadePageRoute(child: ItemEditPage(item)));
                        if (res == ItemEditResult.deleted ||
                            res == ItemEditResult.succeed)
                          Navigator.of(context).pop();
                      },
                    )
                  : Container(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: item.key,
                    child: Image.network(
                      item.photos[0],
                      fit: BoxFit.cover,
                      height: 20,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0),
                          Color(0),
                          Color(0)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Item description.
          SliverList(
            delegate: SliverChildListDelegate(_buildDetails(context)),
          ),

          // Photos.
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (_, index) => Image.network(item.photos[index]),
                childCount: item.photos.length),
          ),

          // Comments.
          SliverList(
            delegate: SliverChildListDelegate(_buildComments(context)),
          ),
        ],
      ),
    );
  }
}
