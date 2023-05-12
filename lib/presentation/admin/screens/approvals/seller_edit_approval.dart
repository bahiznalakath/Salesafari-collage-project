import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/admin/screens/approvals/widgets/edit_card.dart';
import 'package:lottie/lottie.dart';

class SellerEditsPage extends StatelessWidget {
  const SellerEditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Changes")
          .where('userType', isEqualTo: 'p')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          default:
            if (snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 15, left: 10, right: 10, top: 15),
                child: ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemBuilder: (context, index) {
                      DocumentSnapshot document1 = snapshot.data!.docs[index];
                      return SellerEditCard(
                        passingdocument: document1,
                      );
                    }),
              );
            } else {
              return Center(
                  child: Lottie.asset('assets/lottie/empty_box.json',
                      width: size.width * .75));
            }
        }
      },
    );
  }
}


// !!!!!!!!!!test code do not commit!!!!!!!!!!!



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sample_project/presentation/admin/screens/approvals/widgets/edit_card.dart';

// class SellerEditsPage extends StatefulWidget {
//   const SellerEditsPage({Key? key}) : super(key: key);

//   @override
//   _SellerEditsPageState createState() => _SellerEditsPageState();
// }

// class _SellerEditsPageState extends State<SellerEditsPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   List<DocumentSnapshot> _items = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _removeItem(int index) {
//     final removedItem = _items.removeAt(index);
//     _listKey.currentState?.removeItem(
//       index,
//       (context, animation) => SizeTransition(
//         sizeFactor: animation,
//         child: SellerEditCard(passingdocument: removedItem),
//       ),
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("Changes")
//           .where('userType', isEqualTo: 'p')
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.blue),
//             );
//           default:
//             if (snapshot.data!.docs.isNotEmpty) {
//               _items = snapshot.data!.docs.toList();
//               return AnimatedList(
//                 key: _listKey,
//                 initialItemCount: _items.length,
//                 itemBuilder: (context, index, animation) {
//                   DocumentSnapshot document1 = _items[index];
//                   return SizeTransition(
//                     sizeFactor: animation,
//                     child: SellerEditCard(
//                       passingdocument: document1,
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(
//                 child: const Text(
//                   'empty',
//                 ),
//               );
//             }
//         }
//       },
//     );
//   }
// }

