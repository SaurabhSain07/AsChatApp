import 'package:aschatapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child:const Center(
                          child: Icon(Icons.image, size: 50,),
                        ),
                      ),
                    
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Persenal info", style: Theme.of(context).textTheme.labelLarge,),
                      ],
                    ),
        
                    SizedBox(height: 20,),
                     Row(
                       children: [
                         Text("Name", style: Theme.of(context).textTheme.bodyMedium,),
                       ],
                     ),
        
                    SizedBox(height: 10,),
                     TextField(
                      decoration: InputDecoration(
                        hintText: "Saurabh Sain",
                        prefixIcon: Icon(Icons.person)
                      ),
                     ),
        
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         Text("Email Id", style: Theme.of(context).textTheme.bodyMedium,),
                       ],
                     ),
        
                    SizedBox(height: 10,),
                     TextField(
                      decoration: InputDecoration(
                        hintText: "visual.sain100486@gmail.com",
                        prefixIcon: Icon(Icons.alternate_email_outlined)
                      ),
                     ),
        
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         Text("Phrone Number", style: Theme.of(context).textTheme.bodyMedium,),
                       ],
                     ),
        
                    SizedBox(height: 10,),
                     TextField(
                      decoration: InputDecoration(
                        hintText: "8126688733",
                        prefixIcon: Icon(Icons.phone)
                      ),
                     ),
                     
                     SizedBox(height: 20,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         PrimaryButton(btnName: "Save", icon: Icons.save, ontap: (){}),
                       ],
                     )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
