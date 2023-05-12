import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/core/colors/importedTheme.dart';

final user = FirebaseAuth.instance.currentUser;

class SellerEditCard extends StatelessWidget {
  DocumentSnapshot passingdocument;
  SellerEditCard({super.key, required this.passingdocument});

  final auth = FirebaseAuth.instance.currentUser;
  final storeUser = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final newdatadb = FirebaseFirestore.instance;
    late var docid = passingdocument.id;
    final DocumentReference newdatadoc =
        newdatadb.collection("Users").doc(docid);
    var olddata;
    var newdata = passingdocument;
    final size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
      stream: newdatadoc.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        late final olddata = snapshot.data!;
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          default:
            if (snapshot.data!.exists) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.all(8),
                    childrenPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    leading: const CircleAvatar(
                        radius: 40, child: Icon(Icons.person)),
                    title: Text(
                      'Seller Name : ${olddata['name']}'.toUpperCase(),
                      style: facilityTextStyle,
                    ),
                    subtitle: Text(
                      'Business Name : ${olddata['companyname']}',
                      style: facilityTextStyle,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Previous Details'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.red.shade500,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: size.width * .01),
                      DataTable(
                        border: TableBorder.all(
                            width: 0.02,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        columns: [
                          DataColumn(
                            label: Text(
                              'Field',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.lightBlue),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Details',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.lightBlue),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)
                            )),
                            DataCell(
                              Text(
                                '${olddata['name']}',
                                style: TextStyle(
                                  color: (olddata['name'] == newdata['name'])
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Business Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                            DataCell(
                              Text(
                                '${olddata['companyname']}',
                                style: TextStyle(
                                  color: (olddata['companyname'] ==
                                          newdata['companyname'])
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Pin Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                            DataCell(
                              Text(
                                '${olddata['pincode']}',
                                style: TextStyle(
                                  color:
                                      (olddata['pincode'] == newdata['pincode'])
                                          ? Colors.black
                                          : Colors.red,
                                ),
                              ),
                            )
                          ]),
                          // DataRow(cells: [
                          //   DataCell(Text(
                          //     'Phone Number',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 16),
                          //   )),
                          //   DataCell(
                          //     Text(
                          //       '${olddata['phone']}',
                          //       style: TextStyle(
                          //         color: (olddata['phone'] == newdata['phone'])
                          //             ? Colors.black
                          //             : Colors.red,
                          //       ),
                          //     ),
                          //   )
                          // ]),
                        ],
                      ),
                      SizedBox(height: size.width * .02),
                      Center(
                        child: Text(
                          'New Details'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.green.shade300,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: size.width * .01),
                      DataTable(
                        border: TableBorder.all(
                            width: 0.02,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Field',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.lightBlue),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Details',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.lightBlue),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                            DataCell(
                              Text(
                                '${newdata['name']}',
                                style: TextStyle(
                                  color: (olddata['name'] == newdata['name'])
                                      ? Colors.black
                                      : Colors.green,
                                ),
                              ),
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Business Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                            DataCell(
                              Text(
                                '${newdata['companyname']}',
                                style: TextStyle(
                                  color: (olddata['companyname'] ==
                                          newdata['companyname'])
                                      ? Colors.black
                                      : Colors.green,
                                ),
                              ),
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Pin Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                            DataCell(
                              Text(
                                '${newdata['pincode']}',
                                style: TextStyle(
                                  color:
                                      (olddata['pincode'] == newdata['pincode'])
                                          ? Colors.black
                                          : Colors.green,
                                ),
                              ),
                            )
                          ]),
                          // DataRow(cells: [
                          //   DataCell(Text(
                          //     'Phone Number',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 16),
                          //   )),
                          //   DataCell(
                          //     Text(
                          //       '${olddata['phone']}',
                          //       style: TextStyle(
                          //         color: (olddata['phone'] == newdata['phone'])
                          //             ? Colors.black
                          //             : Colors.green,
                          //       ),
                          //     ),
                          //   )
                          // ]),
                        ],
                      ),
                      SizedBox(height: size.width * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              onPressed: () => {
                                    // code to approve data ie update data in Users collection and delete from changes collection

                                    storeUser
                                        .collection("Users")
                                        .doc(docid)
                                        .update({
                                      'name': newdata['name'],
                                      'pincode': newdata['pincode'],
                                      'companyname': newdata['companyname'],
                                    }),
                                    storeUser
                                        .collection("Changes")
                                        .doc(docid)
                                        .delete()
                                  },
                              icon: const Icon(Icons.done),
                              label: const Text('Approve')),
                          const SizedBox(width: 10),
                          const Spacer(),
                          ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              onPressed: () => {
                                    // code to approve data ie remove data from Changes in collection

                                    storeUser
                                        .collection("Changes")
                                        .doc(docid)
                                        .delete()
                                  },
                              icon: const Icon(Icons.close),
                              label: const Text('Reject')),
                          const Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: const Text(
                  'empty',
                ),
              );
            }
        }
      },
    );
  }
}
