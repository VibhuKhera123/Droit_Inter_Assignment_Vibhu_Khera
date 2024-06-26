import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_list/user_list_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _age = TextEditingController();

  UserListController controller = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _userName,
            decoration: InputDecoration(
                labelText: 'User Name', hintText: 'Please enter User Name'),
          ),
          TextField(
            controller: _age,
            decoration: InputDecoration(
                labelText: 'Age', hintText: 'Please enter the age'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_userName.text == "" || _age.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fields Cannot be empty!')));
                _userName.clear();
                _age.clear();
              } else {
                controller.addUserDetails(_userName.text, int.parse(_age.text));
                _userName.clear();
                _age.clear();
              }
            },
            child: const Text('Add User'),
          ),
          Obx(() {
            return controller.userDetails.length == 0
                ? Text('No user added yet')
                : Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: controller.userDetails.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Center(
                            child: Column(
                              children: [
                                Text(controller.userDetails[index]['name']),
                                Text(controller.userDetails[index]['age']
                                    .toString()),
                                IconButton(
                                    onPressed: () {
                                      controller.removeUserDetails(controller
                                          .userDetails[index]['name']);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          })
        ],
      ),
    );
  }
}
