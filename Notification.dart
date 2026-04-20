import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constans/Color.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _markAllAsRead();
  }


  Future<void> deleteAll() async {
    final query = await FirebaseFirestore.instance
        .collection('Notification')
        .where('uid', isEqualTo: uid)
        .get();

    for (var doc in query.docs) {
      doc.reference.delete();
    }
  }
  /// Update all notifications of this user to "isRead = true"
  Future<void> _markAllAsRead() async {
    final query = await FirebaseFirestore.instance
        .collection('Notification')
        .where('uid', isEqualTo: uid)
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in query.docs) {
      doc.reference.update({'isRead': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: [IconButton(onPressed: deleteAll, icon: Icon(Icons.delete))],
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColors.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notification')
            .where('uid', isEqualTo: uid)
           // .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final data = notifications[index].data() as Map<String, dynamic>;

              final storeName = data['storeName'] ?? "Unknown store";
              final productName = data['productName'] ?? "Unknown product";
              final reason = data['reason'] ?? "No reason";
              final timestamp = data['timestamp'];

              final message =
                  "$storeName has rejected your order for $productName.\nReason: $reason";

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: MyColors.primary.withOpacity(0.8),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: const Text(
                    "Order Update",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    message,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: timestamp != null
                      ? Text(
                    _formatTimestamp(timestamp),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Convert Timestamp to readable string
  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} "
        "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
