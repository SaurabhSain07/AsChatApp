import 'package:aschatapp/Model/ChatRoomModel.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList=<ChatRoomModel>[].obs;

  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      await db.collection("users").get().then(
            (value) => {
              userList.value = value.docs
                  .map(
                    (e) => UserModel.fromJson(e.data()),
                  )
                  .toList(),
            },
          );
    } catch (ex) {
      print(ex);
    }
    isLoading.value = false;
  }
  
  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempRoomList = [];
    await db
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .get()
        .then((value) => {
              tempRoomList = value.docs
                  .map((e) => ChatRoomModel.fromJson(e.data()))
                  .toList()
            });

        chatRoomList.value = tempRoomList
        .where((e) => e.id!.contains(auth.currentUser!.uid))
        .toList();
        print(chatRoomList);
  }
  
  Future<void> saveContact(UserModel user)async{
    try {
      await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .doc(user.id)
        .set(user.toJson());
    } catch (ex) {
      if (kDebugMode) {
        print("Error while saving contant"+ex.toString());
      }
    }
  }
  
   Stream<List<UserModel>> getContact(){
     return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docs) => UserModel.fromJson(docs.data())).toList());
  }
}
