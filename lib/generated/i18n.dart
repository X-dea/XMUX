import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get Calendar_Attendance => "Attendance";
  String get Calendar_AttendanceMarkAbsent => "Mark as Absent";
  String get Calendar_AttendanceMarkAttended => "Mark as Attended";
  String get Calendar_AttendanceRate => "Attendance";
  String get Calendar_AttendanceSignIn => "Sign in";
  String get Calendar_AttendanceSignInFinished => "Succeeded";
  String get Calendar_AttendanceSignInMarked => "Waiting...";
  String get General_Continue => "Continue";
  String get General_Weekday1 => "Monday";
  String get General_Weekday2 => "Tuesday";
  String get General_Weekday3 => "Wednesday";
  String get General_Weekday4 => "Thursday";
  String get General_Weekday5 => "Friday";
  String get General_Weekday6 => "Saturday";
  String get General_Weekday7 => "Sunday";
  String get Settings_Sessions => "Sessions";
  String get SignIn_CampusID => "Campus ID";
  String get SignIn_Docs => "Help Docs";
  String get SignIn_ErrorDeprecated => "Please upgrade! The version of app is no longer supported!";
  String get SignIn_ErrorFormat => "Format error, please check.";
  String get SignIn_ErrorGMS => "GMS not working properly.";
  String get SignIn_ErrorInvalidPassword => "Invalid username or password.";
  String get SignIn_InstallGMS => "Install GMS";
  String get SignIn_Password => "Password";
  String get SignIn_Privacy => "Privacy Policy";
  String get SignIn_Read => "By signing in, you agree to our privacy policy & disclaimer";
  String get SignIn_Register => "Register";
  String get SignIn_RegisterCaption => "We still need some information to finish your registration.";
  String get SignIn_RegisterDisplayName => "Display Name";
  String get SignIn_RegisterEmail => "Email";
  String get SignIn_RegisterTitle => "Welcome to XMUM!";
  String get SignIn_SignIn => "Sign in";
  String Calendar_AttendanceSignInFailed(String tip) => "Failed: $tip";
  String General_Error(String tip) => "Error: $tip";
}

class $en extends S {
  const $en();
}

class $zh_CN extends S {
  const $zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get Calendar_Attendance => "考勤";
  @override
  String get SignIn_ErrorFormat => "格式不正确，请检查。";
  @override
  String get SignIn_InstallGMS => "安装 GMS";
  @override
  String get SignIn_CampusID => "校园ID";
  @override
  String get SignIn_Register => "注册";
  @override
  String get Calendar_AttendanceSignInMarked => "等待确认···";
  @override
  String get SignIn_Privacy => "隐私政策";
  @override
  String get Calendar_AttendanceMarkAttended => "标记为出席";
  @override
  String get SignIn_Password => "密码";
  @override
  String get SignIn_ErrorDeprecated => "该版本应用已不再受到支持，请更新！";
  @override
  String get Calendar_AttendanceSignIn => "签到";
  @override
  String get Calendar_AttendanceRate => "出勤率";
  @override
  String get SignIn_Docs => "帮助文档";
  @override
  String get SignIn_ErrorGMS => "GMS 未正常工作";
  @override
  String get SignIn_SignIn => "登录";
  @override
  String get SignIn_RegisterTitle => "欢迎来到 XMUM！";
  @override
  String get SignIn_ErrorInvalidPassword => "用户名或密码无效";
  @override
  String get Settings_Sessions => "会话";
  @override
  String get General_Weekday7 => "周日";
  @override
  String get General_Weekday6 => "周六";
  @override
  String get General_Weekday5 => "周五";
  @override
  String get General_Weekday4 => "周四";
  @override
  String get General_Weekday3 => "周三";
  @override
  String get General_Continue => "继续";
  @override
  String get General_Weekday2 => "周二";
  @override
  String get General_Weekday1 => "周一";
  @override
  String get SignIn_RegisterEmail => "邮箱";
  @override
  String get Calendar_AttendanceSignInFinished => "签到成功";
  @override
  String get Calendar_AttendanceMarkAbsent => "标记为缺席";
  @override
  String get SignIn_RegisterCaption => "我们仍需要以下信息以完成注册。";
  @override
  String get SignIn_Read => "登录即代表您同意我们的隐私政策和免责声明";
  @override
  String Calendar_AttendanceSignInFailed(String tip) => "签到失败： $tip";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", "CN"),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh_CN":
          S.current = const $zh_CN();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
