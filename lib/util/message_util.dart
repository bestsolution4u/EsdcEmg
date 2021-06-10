import 'package:esdc_emg/model/message_model.dart';

import '../model/message_model.dart';

class MessageUtils {
  static List<MessageModel> filterUrgentMessages(List<MessageModel> messages) {
    return messages.where((element) => element.urgentInd == 'Urgent').toList();
  }

  static List<MessageModel> filterNonUrgentMessages(List<MessageModel> messages) {
    return messages.where((element) => element.urgentInd != 'Urgent').toList();
  }

  static int getLastMessageId(List<MessageModel> messages) {
    int last = 0;
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].id > last) last = messages[i].id;
    }
    return last;
  }

  static List<MessageModel> sortMessageFromNewToOld(List<MessageModel> messages) {
    messages.sort((a, b) {
      DateTime dateA = DateTime.parse(a.effectiveDate);
      DateTime dateB = DateTime.parse(b.effectiveDate);
      int diff = dateB.compareTo(dateA);
      if (diff != 0) return diff;
      return b.id.compareTo(a.id);
    });
    return messages;
  }

  static List<MessageModel> sortMessageFromOldToNew(List<MessageModel> messages) {
    messages.sort((a, b) {
      DateTime dateA = DateTime.parse(a.effectiveDate);
      DateTime dateB = DateTime.parse(b.effectiveDate);
      int diff = dateA.compareTo(dateB);
      if (diff != 0) return diff;
      return a.id.compareTo(b.id);
    });
    return messages;
  }

  static String parseISO8601(String value) {
    String result = '';
    value = value.replaceAll('PT', '');
    List<String> mins = value.split('M');
    if (mins.length > 1) {
      List<String> hours = mins[0].split('H');
      String minutes = '';
      if (hours.length > 1) {
        if (hours[0].length == 1) {
          result += '0';
        }
        result += hours[0];
        result += ':';
        minutes = hours[1];
      } else {
        minutes = hours[0];
      }
      if (minutes.length == 1) {
        result += '0';
      }
      result += minutes;
      result += ':';
      List<String> secs = mins[1].split('S');
      if (secs[0].length == 1) {
        result += '0';
      }
      result += secs[0];
    } else {
      result += '00:';
      List<String> secs = mins[0].split('S');
      if (secs[0].length == 1) {
        result += '0';
      }
      result += secs[0];
    }

    return result;
  }
}