import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:vote_sphere/screens/admin/show_election.dart';

class CreateElectionScreen extends StatelessWidget {
  const CreateElectionScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Election'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CreateElectionForm(),
      ),
    );
  }
}

class CreateElectionForm extends StatefulWidget {
  @override
  _CreateElectionFormState createState() => _CreateElectionFormState();
}

class _CreateElectionFormState extends State<CreateElectionForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'electionId',
            decoration: InputDecoration(labelText: 'Election ID'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime(2030),
              );

              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                  _formKey.currentState?.fields['electionDate']
                      ?.didChange(pickedDate);
                });
              }
            },
            child: AbsorbPointer(
              child: FormBuilderDateTimePicker(
                name: 'electionDate',
                inputType: InputType.date,
                format: DateFormat('dd-MM-yyyy'),
                initialValue: _selectedDate,
                decoration: InputDecoration(labelText: 'Election Date'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'electionName',
            decoration: InputDecoration(labelText: 'Election Name'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                // Handle form data here
                var formData = _formKey.currentState!.value;
                print(formData);

                // Navigate to ShowElectionsScreen and pass the form data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowElectionsScreen(formData: formData),
                  ),
                );
              }
            },
            child: Text('Create Election'),
          ),
        ],
      ),
    );
  }
}
