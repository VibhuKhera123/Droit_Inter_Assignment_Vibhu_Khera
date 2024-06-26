import 'package:get/get.dart';

class UserListController extends GetxController {
  RxList userDetails = [].obs;

  void addUserDetails(String userName, int age) {
    userDetails.add({'name': userName, 'age': age});
    update();
  }

  void removeUserDetails(String userName) {
    userDetails.removeWhere(
      (element) => element['name'] == userName,
    );
  }
}
