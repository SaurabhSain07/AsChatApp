import 'package:aschatapp/Model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Model/AudioCall.dart';

class CallController extends GetxController{
  final db=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;
  final uuid=Uuid().v4();

  void onInti(){
    super.onInit();
    getCallsNotification().listen((List<CallModel> calllist) { 
      if (calllist.isNotEmpty) {
        var callData=calllist[0];
        Get.snackbar(callData.callerName!, "Incoming Call");
      }
    });
  }

  Future<void> CallAction(UserModel reciver, UserModel caller)async{
    String id=uuid;
    var newCall=CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: reciver.name,
      receiverPic: reciver.profileImage,
      receiverUid: reciver.id,
      receiverEmail: reciver.email,
      status: "dialing"
    );

    try {
      await db
          .collection("notification")
          .doc(reciver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(reciver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      Future.delayed(Duration(minutes: 1),(){
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }
  
  Stream<List<CallModel>> getCallsNotification() {
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots().map((snapshot) => snapshot.docs.map((doc) => CallModel.fromJson(doc.data())).toList());
  }

  Future<void> endCall(CallModel call)async{
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}