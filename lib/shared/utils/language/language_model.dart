/*
PERHATIAN!!!
File ini dibuat secara otomatis oleh code-gen.dart   
Jika anda tidak mengerti isi dalam file ini, dimohon untuk
tidak mengubah apapun!,
terima kasih!.
*/
import 'package:flutter/material.dart';
import 'package:mtelektrik/config/language.dart';

class LanguageModel {
  final String? networkErrorConnectionTimeout;
  final String? networkErrorSendTimeout;
  final String? networkErrorReceiveTimeout;
  final String? networkErrorServer;
  final String? networkErrorConnectionCancel;
  final String? networkErrorInternal;
  final String? greetingUser;
  final String? followedQueueNotificationThisWeek;
  final String? seeDetail;
  final String? latestQueue;
  final String? popularQueue;
  final String? seeAll;
  final String? introTitlePage1;
  final String? introDescriptionPage1;
  final String? introTitlePage2;
  final String? introDescriptionPage2;
  final String? introTitlePage3;
  final String? introDescriptionPage3;
  final String? cancel;
  final String? searchHint;
  final String? searchHistory;
  final String? removeSearchHistory;
  final String? searchPopular;
  final String? filterQueue;
  final String? resetFilter;
  final String? apply;
  final String? sort;
  final String? category;
  final String? locationQueue;
  final String? organizer;
  final String? queueType;
  final String? buttonStart;
  final String? participant;
//code-gen.dart - tolong jangan dihapus comment ini!
  const LanguageModel({
    this.networkErrorConnectionTimeout,
    this.networkErrorSendTimeout,
    this.networkErrorReceiveTimeout,
    this.networkErrorServer,
    this.networkErrorConnectionCancel,
    this.networkErrorInternal,
    this.greetingUser,
    this.followedQueueNotificationThisWeek,
    this.seeDetail,
    this.latestQueue,
    this.popularQueue,
    this.seeAll,
    this.introTitlePage1,
    this.introDescriptionPage1,
    this.introTitlePage2,
    this.introDescriptionPage2,
    this.introTitlePage3,
    this.introDescriptionPage3,
    this.cancel,
    this.searchHint,
    this.searchHistory,
    this.removeSearchHistory,
    this.searchPopular,
    this.filterQueue,
    this.resetFilter,
    this.apply,
    this.sort,
    this.category,
    this.locationQueue,
    this.organizer,
    this.queueType,
    this.buttonStart,
    this.participant,
//code-gen.dart - tolong jangan dihapus comment ini!
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        networkErrorConnectionTimeout:
            json['networkErrorConnectionTimeout'] as String?,
        networkErrorSendTimeout: json['networkErrorSendTimeout'] as String?,
        networkErrorReceiveTimeout:
            json['networkErrorReceiveTimeout'] as String?,
        networkErrorServer: json['networkErrorServer'] as String?,
        networkErrorConnectionCancel:
            json['networkErrorConnectionCancel'] as String?,
        networkErrorInternal: json['networkErrorInternal'] as String?,
        greetingUser: json['greetingUser'] as String?,
        followedQueueNotificationThisWeek:
            json['followedQueueNotificationThisWeek'] as String?,
        seeDetail: json['seeDetail'] as String?,
        latestQueue: json['latestQueue'] as String?,
        popularQueue: json['popularQueue'] as String?,
        seeAll: json['seeAll'] as String?,
        introTitlePage1: json['introTitlePage1'] as String?,
        introDescriptionPage1: json['introDescriptionPage1'] as String?,
        introTitlePage2: json['introTitlePage2'] as String?,
        introDescriptionPage2: json['introDescriptionPage2'] as String?,
        introTitlePage3: json['introTitlePage3'] as String?,
        introDescriptionPage3: json['introDescriptionPage3'] as String?,
        cancel: json['cancel'] as String?,
        searchHint: json['searchHint'] as String?,
        searchHistory: json['searchHistory'] as String?,
        removeSearchHistory: json['removeSearchHistory'] as String?,
        searchPopular: json['searchPopular'] as String?,
        filterQueue: json['filterQueue'] as String?,
        resetFilter: json['resetFilter'] as String?,
        apply: json['apply'] as String?,
        sort: json['sort'] as String?,
        category: json['category'] as String?,
        locationQueue: json['locationQueue'] as String?,
        organizer: json['organizer'] as String?,
        queueType: json['queueType'] as String?,
        buttonStart: json['buttonStart'] as String?,
        participant: json['participant'] as String?,
//code-gen.dart - tolong jangan dihapus comment ini!
      );
  Widget langArgumentToRichText(
      {required String text,
      required List<String> args,
      TextStyle? textStyle,
      List<TextStyle>? argsTextStyle,
      int maxlines = 2,
      bool softwrap = true,
      TextAlign? textAlign}) {
    return text.langArgumentToRichText(
        args: args,
        textStyle: textStyle,
        argsTextStyle: argsTextStyle,
        maxlines: maxlines,
        softwrap: softwrap,
        textAlign: textAlign);
  }
}
