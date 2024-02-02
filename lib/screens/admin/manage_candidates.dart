import 'package:flutter/material.dart';
import 'package:vote_sphere/models/manage_candidates_model.dart';
import '../../services/database_helper.dart';

class ManageCandidatesScreen extends StatefulWidget {
  const ManageCandidatesScreen({Key? key}) : super(key: key);

  @override
  _ManageCandidatesScreenState createState() => _ManageCandidatesScreenState();
}

class _ManageCandidatesScreenState extends State<ManageCandidatesScreen> {
  late Future<List<ManageCandidatesModel>> candidatesList;

  @override
  void initState() {
    super.initState();
    candidatesList = DatabaseHelper.getAllCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Candidates'),
        backgroundColor: Colors.green.shade600,
      ),
      body: FutureBuilder<List<ManageCandidatesModel>>(
        future: candidatesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No candidates available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final candidate = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Name: ${candidate.name}'),
                    subtitle: Text('Department: ${candidate.department}'),
                    // Add more ListTile items based on your data model
                    // ...
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Implement deletion logic here
                        // You might want to show a confirmation dialog
                        // and then call DatabaseHelper.deleteCandidate(candidate);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
