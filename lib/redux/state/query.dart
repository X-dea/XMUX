import 'package:json_annotation/json_annotation.dart';
import 'package:xmux/modules/emgs/model.dart';
import 'package:xmux/modules/moodle/models/assignment.dart';
import 'package:xmux/modules/rpc/clients/aaos.pb.dart';
import 'package:xmux/modules/xmux_api/models/models_v2.dart';

part 'query.g.dart';

@JsonSerializable()
class QueryState {
  /// Assignments from moodle.
  final List<AssignmentCourse> assignments;

  /// Billing records from E-Payment.
  final List<BillingRecord> ePaymentRecords;

  /// Application status for VISA.
  final EmgsApplicationResult emgsApplicationResult;

  /// Timetable for current semester.
  final Timetable timetable;

  /// Courses for current semester.
  final Courses courses;

  /// Exams for current semester.
  final Exams exams;

  /// Transcript of student.
  final Transcript transcript;

  QueryState({
    this.assignments,
    this.ePaymentRecords,
    this.emgsApplicationResult,
    Timetable timetable,
    Courses courses,
    Exams exams,
    Transcript transcript,
  })  : timetable = timetable ?? Timetable(),
        courses = courses ?? Courses(),
        exams = exams ?? Exams(),
        transcript = transcript ?? Transcript();

  factory QueryState.fromJson(Map<String, dynamic> json) =>
      _$QueryStateFromJson(json);

  Map<String, dynamic> toJson() => _$QueryStateToJson(this);

  QueryState copyWith({
    List<AssignmentCourse> assignments,
    List<BillingRecord> ePaymentRecords,
    EmgsApplicationResult emgsApplicationResult,
    Timetable timetable,
    Courses courses,
    Exams exams,
    Transcript transcript,
  }) =>
      QueryState(
        assignments: assignments ?? this.assignments,
        ePaymentRecords: ePaymentRecords ?? this.ePaymentRecords,
        emgsApplicationResult:
            emgsApplicationResult ?? this.emgsApplicationResult,
        timetable: timetable ?? this.timetable,
        courses: courses ?? this.courses,
        exams: exams ?? this.exams,
        transcript: transcript ?? this.transcript,
      );
}
