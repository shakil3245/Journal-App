
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


import '../../controller/authController.dart';
import '../../controller/journalController.dart';
import 'addJournalByUser.dart';


class UserHomeScreen extends StatelessWidget {
  final JournalController journalController = Get.put(JournalController());
  final AuthController authcontroller = Get.put(AuthController());

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Journals Worlds",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
              print('Search tapped');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: "Logout",
                middleText: "Do you want to logout?",
                textConfirm: "Yes",
                textCancel: "No",
                onConfirm: () {
                  Get.back();
                  authcontroller.logout();
                },
              );
            },
          ),
        ],
      ),
      body:  Obx((){
        if(journalController.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(child: ListView.builder(
          itemCount:journalController.journalsList.length,
          itemBuilder: (_, index) {
            var journals = journalController.journalsList[index];
            return Card(
              child: ListTile(
                title: Text(journals.title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(journals.content),
                    Text("Author:${journals.author.username}")
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                    IconButton(icon: Icon(Icons.delete), onPressed: () {
                      journalController.deletePost(journals.id.toString());
                    }),
                  ],
                ),
              ),
            );
          },
        ), onRefresh: ()async{
           journalController.fetchJournals();
        });
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(PostPage());
        },
      ),
    );
  }
}
