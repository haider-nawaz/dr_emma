import 'package:get/get.dart';

class UserController extends GetxController {
  var userIssues = <String>[].obs;
  var empUnd = 2.obs; // Empathy and Understanding
  var lisSol = 3.obs; // Listening and Solution
  var hoTa = 1.obs; // Holistic and Targeted

  var selectedConvMode = 0.obs; // 0 for text, 1 for voice,

  void addIssue(String issue) {
    if (userIssues.contains(issue)) {
      userIssues.remove(issue);
    } else {
      userIssues.add(issue);
    }
  }

  void updateEmpathy(double value) {
    empUnd.value = value.round();
  }
}
