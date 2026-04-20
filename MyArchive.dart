import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_the_way/constans/Color.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  Stream<QuerySnapshot> _getCompletedOrders() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("Orders")
        .where("state", isEqualTo: 4)
       .where("customerId", isEqualTo: uid)
    // .orderBy("date", descending: true)
        .snapshots();
  }

  Future<void> _showEarningsDialog(
      BuildContext context, List<QueryDocumentSnapshot> orders) async {
    // calculate total delivery income
    double totalDelivery = 0;
    for (var order in orders) {
      totalDelivery += (order["delivery"] ?? 0).toDouble();
    }

    double payout = totalDelivery * 0.3;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Earnings Summary"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total Delivery Income: \$${totalDelivery.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Your Payout (30%): \$${payout.toStringAsFixed(2)}",
                style:  TextStyle(fontSize: 16, color: MyColors.primary)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // delete all completed orders
              for (var doc in orders) {
                await FirebaseFirestore.instance
                    .collection("Orders")
                    .doc(doc.id)
                    .delete();
              }
              Navigator.pop(context);
            },
            child: const Text("Confirm & Clear",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Archive"),
        centerTitle: true,
        backgroundColor:MyColors.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getCompletedOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("No completed orders yet",
                    style: TextStyle(fontSize: 18)));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order["productName"] ?? "No Product",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text("Store: ${order["storeName"] ?? "Unknown"}",
                          style: const TextStyle(color: Colors.black54)),
                      Text("Price: \$${order["price"] ?? 0}"),
                      Text("Quantity: ${order["numberOfProduct"] ?? 1}"),
                      Text("Total: \$${order["totalPrice"] ?? 0}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text("Delivery Fee: \$${order["delivery"] ?? 0}",
                          style:  TextStyle(color: MyColors.primary)),
                      const SizedBox(height: 6),
                      Text("Customer Phone: ${order["phoneNumber"] ?? "N/A"}"),
                      Text("Note: ${order["additions"] ?? "-"}"),
                      const SizedBox(height: 8),
                      Text(
                        "Date: ${order["date"] != null ? (order["date"] as Timestamp).toDate().toString() : "Unknown"}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
