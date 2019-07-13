import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xmux/components/empty_error_button.dart';
import 'package:xmux/components/empty_error_page.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/modules/xmux_api/xmux_api_v2.dart';
import 'package:xmux/redux/redux.dart';

class ExamsPage extends StatelessWidget {
  final List<Exam> exams;

  ExamsPage(this.exams);

  // Handle refresh.
  Future<Null> _handleUpdate() async {
    var act = UpdateAcAction();
    store.dispatch(act);
    await act.listener;
  }

  Widget _buildLastUpdateString(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "${i18n('Calendar/LastUpdate', context)} "
          '${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(store.state.acState.timestamp)} '
          '${DateFormat.Hms(Localizations.localeOf(context).languageCode).format(store.state.acState.timestamp)}',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => exams == null
      ? EmptyErrorButton(onRefresh: _handleUpdate)
      : exams.isEmpty
          ? EmptyErrorPage()
          : RefreshIndicator(
              onRefresh: _handleUpdate,
              child: ListView.builder(
                itemCount: exams.length + 1,
                itemBuilder: (_, int index) {
                  if (index == exams.length)
                    // Build last update string.
                    return _buildLastUpdateString(context);
                  else
                    // Build exam card.
                    return _ExamCard(exams[index]);
                },
              ),
            );
}

class _ExamCard extends StatelessWidget {
  final Exam examData;

  _ExamCard(this.examData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                examData.courseName,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Text('${examData.date.toString().substring(0, 10)} '
                "${i18n('Weekdays/${examData.date.weekday}', context)} "
                '${examData.durationOfDay.start.format(context)} - '
                '${examData.durationOfDay.end.format(context)}'),
            Text(examData.venue),
            Text('${examData.type}, ${examData.status}'),
          ],
        ),
      ),
    );
  }
}
