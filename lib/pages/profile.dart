import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:myreceiptapp/pages/login.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool imageSelected = false;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool _isLoading = false;
  String? addId, pic, name, email;
  int a = 0;
  TextEditingController namecontroller = new TextEditingController();

  gethisonSharedpref() async {
    pic = await SharedPreferenceHelper().getUserProfileUrl();
    name = await SharedPreferenceHelper().getDisplayName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  onthisload() async {
    await gethisonSharedpref();
    namecontroller.text = name!;
  }

  @override
  void initState() {
    super.initState();
    onthisload();
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      addId = randomAlphaNumeric(9);

      /// uploading image to firebase storage
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId!);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downloadUrl");
      SharedPreferenceHelper().saveUserProfileUrl(downloadUrl);
      setState(() {});

      //     task.whenComplete(() {
      //     var url = ref.getDownloadURL();
      //  }).catchError((onError) {
      //   print(onError);
      //   });
    }
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    await uploadBlog();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pic == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              const SizedBox(
                height: 30.0,
              ),
              selectedImage == null
                  ? GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Center(
                    child: Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          pic!,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              )
                  : Center(
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.file(
                        selectedImage!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 70.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 35.0,
                      color: Color(0xFF42A132),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          namecontroller.text,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        openAdditem();
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 35.0,
                      color: Color(0xFF42A132),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          email!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => logIn()));
                },
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF42A132),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openAdditem() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.green,
                        )),
                    const SizedBox(
                      width: 50.0,
                    ),
                    const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: namecontroller,
                    decoration: const InputDecoration(
                        hintText: "Fill Item name",
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPreferenceHelper()
                        .saveDisplayName(namecontroller.text);
                    a++;
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xFF42A232),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Change",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}
