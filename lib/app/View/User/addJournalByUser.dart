import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/journalController.dart';
import '../widgets/cutomButton.dart';


class PostPage extends StatelessWidget {
  final JournalController controller = Get.put(JournalController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 32),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : InkWell(
              onTap: (){
                controller.createPost(
                  titleController.text.toString(),
                  descriptionController.text.toString(),
                );
              },
                child: customButton(buttonName: "Post",))),
          ],
        ),
      ),
    );
  }
}
