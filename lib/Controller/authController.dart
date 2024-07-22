
import 'package:aschatapp/Model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final auth=FirebaseAuth.instance;
  final db=FirebaseFirestore.instance;
  RxBool isLoading=false.obs;

  Future<void> login(String email, String password)async{
    isLoading.value=true;
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed("/homePage");
    }on FirebaseAuthException catch(e){
      if (e.code=='user not found') {
        print("user not found for that email");
      }else if(e.code=='worng password'){
        print("worng password provid for that user");
      }
    }catch(e){
      print(e);
    }
    isLoading.value=false;
  }

  Future<void> createUser(String email, String password, String name) async {
    isLoading.value=true;
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
      await initUser(email, name);
      Get.offAllNamed("/homePage");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        print("user not found for that email");
      } else if (e.code == 'worng password') {
        print("worng password provid for that user");
      }
    } catch (e) {
      print(e);
    }
    isLoading.value=false;
  }

 Future<void> logoutUser()async{
  auth.signOut();
  Get.offAllNamed("/authPage");
 }

 Future <void>initUser(String email, String name)async{
  var newUser =UserModel(
    email: email,
    name: name,
    id: auth.currentUser!.uid,
  );

  try {
    await db.collection("users").doc(auth.currentUser!.uid).set(
      newUser.toJson()
    );
  } catch (ex) {
    print(ex);
  }
 }
}