import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreTestScreen extends StatelessWidget {
  const FirestoreTestScreen({super.key});

  Stream<QuerySnapshot> getBoxesStream() {
    return FirebaseFirestore.instance.collection("Boxes").snapshots();
  }

  Future<Map<String, dynamic>?> getItemById(String id) async {
    final doc = await FirebaseFirestore.instance
        .collection("Boxes")
        .doc("puv2FKt6U9yclDfHBn7R").collection("Items")
        .doc(id)
        .get();
    if (doc.exists) {
      return doc.data();
    } else {
      throw Exception("Dokument mit ID $id nicht gefunden");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore Test")),
      body: Column(
        spacing: 16,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: getBoxesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Etwas ist schiefgelaufen!",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  spacing: 16,
                  children: [
                    Text(
                      "Zähle die Anzahl der Dokumente in einer Sammlung: ${snapshot.data!.docs.length}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        return ListTile(
                          title: Text(doc["name"] ?? "Kein Name"),
                          subtitle: Text(
                            doc["description"] ?? "Keine Beschreibung",
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              );
            },
          ),
          FutureBuilder(
            future: getItemById("uBfrulAJugwN3nT1xiLn"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Etwas ist schiefgelaufen!",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text(
                  "Kein Dokument gefunden",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              final data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  spacing: 16,
                  children: [
                    Text(
                      "${data["name"] ?? "Kein Name"}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${data["description"] ?? "Keine Beschreibung"}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
