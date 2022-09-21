import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectloner/repositories/storage/storage_repo.dart';

class CustomImageCont extends StatelessWidget {
  final TabController tabController;
  const CustomImageCont({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            bottom: BorderSide(color: Colors.deepPurple, width: 1),
            top: BorderSide(color: Colors.deepPurple, width: 1),
            left: BorderSide(color: Colors.deepPurple, width: 1),
            right: BorderSide(color: Colors.deepPurple, width: 1),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.deepPurple),
            onPressed: () async {
              ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image == null) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Image Selected'),
                  ),
                );
              } else {
                debugPrint('Uploading image...');
                StorageRepo().uploadImage(image);
              }
            },
          ),
        ),
      ),
    );
  }
}
