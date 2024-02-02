import 'package:flutter/material.dart';
import 'package:vote_sphere/screens/candidates/candidates_registration.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({Key? key}) : super(key: key);

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('candidate'),
        backgroundColor: Colors.green.shade600,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildCard("Candidate Registration", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CandidatesRegistrationScreen()));
          }),
          buildCard("Check Results", () {
            // Handle manage candidates button click
          }),
          buildCard("Analysis", () {
            // Handle check results button click
          }),
        ],
      ),
    );
  }

  Widget buildCard(String title, VoidCallback onPressed) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text('Go'),
        ),
      ),
    );
  }
}
