import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

final user = FirebaseAuth.instance.currentUser;
final db = FirebaseFirestore.instance;
// final docRef = db.collection("Users").doc(user!.uid);
// var data;

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    // docRef.get().then(
    //   (DocumentSnapshot doc) async {
    //     data = await doc.data() as Map<String, dynamic>;
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: db.collection("Users").doc(user!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 1),
                  const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 60,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data!['name'].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                    width: 150,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Colors.black,
                          )),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Spacer(
                              flex: 3,
                            ),
                            Icon(
                              Icons.logout_outlined,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 20,
                              ),
                            ),
                            Spacer(flex: 3),
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      final pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ScreenSplash()),
                          ModalRoute.withName('/'));
                    },
                  ),
                  const Spacer(flex: 2),
                  const SizedBox(
                    height: 5,
                    width: 150,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'aboutus');
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text('About Us'),
                  ),
                  const SizedBox(
                    height: 20.0,
                    width: 150,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Logined as a Admin'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                    width: 150,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
