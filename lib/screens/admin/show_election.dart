import 'package:flutter/material.dart';

class ShowElectionsScreen extends StatefulWidget {
  final Map<String, dynamic> formData;

  ShowElectionsScreen({required this.formData, Key? key}) : super(key: key);

  @override
  _ShowElectionsScreenState createState() => _ShowElectionsScreenState();
}

class _ShowElectionsScreenState extends State<ShowElectionsScreen> {
  late Map<String, dynamic> formData;

  @override
  void initState() {
    super.initState();
    formData = widget.formData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Election'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formData.isNotEmpty)
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoTile('Election ID', formData['electionId']),
                    _buildInfoTile('Election Date', formData['electionDate']),
                    _buildInfoTile('Election Name', formData['electionName']),
                    // Add more _buildInfoTile widgets for other form fields if needed
                  ],
                ),
              )
            else
              Text('No election data available'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, dynamic value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('$value'),
    );
  }
}
