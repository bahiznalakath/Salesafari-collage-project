import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fetchData extends StatelessWidget {
  const fetchData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
          child: Text('click me'),
          onPressed: (){},
          // onPressed: () async {
          //   String b = await getCurrentUserData('userType');
          //   print(b);
          // },
        ),
      ),
    );
  }
}

// final user = FirebaseAuth.instance.currentUser;

Future<String> getCurrentUserData(User? user,String a) async {
  if (user != null) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // You would need to write a function that gets the current user's ID.
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(user.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print(data[a]);
    return data[a] ?? '';
  } else {
    return 'yy';
  }
}
Future<String> getData(String col,String doc_id,String a) async {
  try{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // You would need to write a function that gets the current user's ID.
    DocumentSnapshot snapshot = await firestore.collection(col).doc(doc_id).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print(data[a]);
    return data[a] ?? 'No Data';
    }catch(e){
      print(e);
      return 'An Error Occured';
    }
  } 
  
