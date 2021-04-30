import 'package:esdc_emg/model/message_model.dart';

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
}