// import 'package:flutter/material.dart';
// import 'package:sample_project/core/colors/Colors.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sample_project/presentation/testdetails.dart';

// class WaitingCard extends StatelessWidget {
//   DocumentSnapshot passingdocument;
//   WaitingCard({Key? key, required this.passingdocument}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     // var name = (passingdocument['name']);
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(20)),
//         child: ExpansionTile(
//           tilePadding: const EdgeInsets.all(8),
//           childrenPadding:
//               const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//           leading: const CircleAvatar(radius: 40, child: Icon(Icons.person)),
//           title:  Text(
//             "Seller Name : ${passingdocument['name']}",
//             style: textStyleHead,
//           ),
//           subtitle:  Text(
//             'Business Name : ${passingdocument['companyname']}',
//             style: textStyleSubhead,
//           ),
//           expandedCrossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Business Address : ${passingdocument['address']}',
//               style: subTextStyle,
//             ),
//             Text(
//               'PIN Code : ${passingdocument['pincode']}',
//               style: subTextStyle,
//             ),
//              Text(
//               'Phone : ${passingdocument['phone']}',
//               style: subTextStyle,
//             ),
//            Text(
//               'Email ID : ${passingdocument['email']}',
//               style: subTextStyle,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset('assets/images/seller.jpg',fit: BoxFit.cover,),
//             ),
//             SizedBox(height: size.width * .02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Spacer(),
//                 ElevatedButton.icon(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.green),
//                     ),
//                     onPressed: () => {
//                         store.collection("Users").doc(passingdocument.id).update({
//                           'userType':'s',
//                           'status':'a'
//                         })
//                     },
//                     icon: const Icon(Icons.done),
//                     label: const Text('Approve')),
//                 const SizedBox(width: 10),
//                 const Spacer(),
//                 ElevatedButton.icon(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.red),
//                     ),
//                     onPressed: () => {
//                       store.collection("Users").doc(passingdocument.id).update({
//                           'status':'r'
//                         })
//                     },
//                     icon: const Icon(Icons.close),
//                     label: const Text('Reject')),
//                 const Spacer()
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/admin/screens/approvals/seller_approval.dart';
import 'package:salesafari/presentation/testdetails.dart';

import '../../../../authentication/login.dart';

class WaitingCard extends StatelessWidget {
  DocumentSnapshot passingdocument;
  WaitingCard({Key? key, required this.passingdocument}) : super(key: key);
  List<String> emails = [];

  void _approveSeller() async {
   try{
     FirebaseFirestore.instance.collection("Users").doc(passingdocument.id).update({
      'userType': 's',
      'status': 'a',
    });

    await FirebaseFirestore.instance.collection('Rejected').get().then((value) {
      value.docs.forEach((element) {
        emails.add(element['email']);
        print(element['email']);
      });
    });
    if (emails.contains(passingdocument['email'])) {
      FirebaseFirestore.instance
          .collection('Rejected')
          .doc(passingdocument['email'])
          .delete();
    }
    }catch (e) {
  print('Error deleting user: $e');
}
  }

  void _rejectSeller(BuildContext context) async {
    await FirebaseFirestore.instance.collection('Rejected').get().then((value) {
      value.docs.forEach((element) {
        emails.add(element['email']);
        print(element['email']);
      });
    });
    if (!emails.contains(passingdocument['email'])) {
      try {
        await FirebaseFirestore.instance
            .collection('Rejected')
            .doc(passingdocument['email'])
            .set({'email': passingdocument['email']});
        FirebaseFirestore.instance
            .collection('Users')
            .doc(passingdocument.id)
            .delete();
        User? user = await FirebaseAuth.instance
            .userChanges()
            .firstWhere((user) => user!.uid == passingdocument.id);
        print(user!.uid);

        await user.delete();
      } catch (e) {
        print('Error deleting user: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: customsnackbar(
            errortext: 'Please enter your email/password',
            errorcolor: Colors.red,
          ),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }

    // store.collection("Users").doc(passingdocument.id).update({
    //   'status': 'r',
    // });
  }

  Widget _buildSellerDetails() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Field')),
        DataColumn(label: Text('Value')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Seller Name')),
          DataCell(Text(passingdocument['name'])),
        ]),
        DataRow(cells: [
          DataCell(Text('Business Name')),
          DataCell(Text(passingdocument['companyname'])),
        ]),
        DataRow(cells: [
          DataCell(Text('Business Address')),
          DataCell(Text(passingdocument['address'])),
        ]),
        DataRow(cells: [
          DataCell(Text('PIN Code')),
          DataCell(Text(passingdocument['pincode'])),
        ]),
        DataRow(cells: [
          DataCell(Text('Phone')),
          DataCell(Text(passingdocument['phone'])),
        ]),
        DataRow(cells: [
          DataCell(Text('Email ID')),
          DataCell(Text(passingdocument['email'])),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(8),
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          leading: const CircleAvatar(radius: 40, child: Icon(Icons.person)),
          title: Text(
            "Seller Name : ${passingdocument['name']}",
            style: facilityTextStyle,
          ),
          subtitle: Text(
            'Business Name : ${passingdocument['companyname']}',
            style: facilityTextStyle,
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSellerDetails(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                passingdocument['proof_image'],
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.width * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    _approveSeller();
                  },
                  icon: Icon(Icons.done),
                  label: Text('Approve', style: buttonTextStyle,),
                ),
                const SizedBox(width: 10),
                const Spacer(),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    _rejectSeller(context);
                  },
                  icon: Icon(Icons.close),
                  label: Text('Reject', style: buttonTextStyle,),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
