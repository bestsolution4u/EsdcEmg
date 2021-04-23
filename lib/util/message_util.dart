import 'package:esdc_emg/model/message_model.dart';

class MessageUtils {
  static List<MessageModel> filterUrgentMessages(List<MessageModel> messages) {
    return messages.where((element) => element.urgentInd == 'Urgent').toList();
  }

  static List<MessageModel> filterNonUrgentMessages(List<MessageModel> messages) {
    return messages.where((element) => element.urgentInd != 'Urgent').toList();
  }
}