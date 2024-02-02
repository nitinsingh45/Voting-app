import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:vote_sphere/models/manage_candidates_model.dart';
import '../../services/database_helper.dart';

class CandidatesRegistrationScreen extends StatelessWidget {
  const CandidatesRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Registration'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'semester',
                  decoration: InputDecoration(labelText: 'Semester'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'post_id',
                  decoration: InputDecoration(labelText: 'Post ID'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'department',
                  decoration: InputDecoration(labelText: 'Department'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'usn',
                  decoration: InputDecoration(labelText: 'USN'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'phone_number',
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.email(),
                ),
                FormBuilderTextField(
                  name: 'election_id',
                  decoration: InputDecoration(labelText: 'Election ID'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderRadioGroup(
                  name: 'gender',
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: FormBuilderValidators.required(),
                  options: ['Male', 'Female', 'Other']
                      .map((gender) => FormBuilderFieldOption(value: gender))
                      .toList(growable: false),
                ),
                FormBuilderImagePicker(
                  name: 'symbol_pic',
                  decoration: InputDecoration(labelText: 'Symbol Pic'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (FormBuilder.of(context)!.saveAndValidate()) {
                      final formData = FormBuilder.of(context)!.value;

                      final String name = formData['name'] ?? '';
                      final String semester = formData['semester'] ?? '';
                      final int? post_id = formData['post_id'] != null
                          ? int.tryParse(formData['post_id']!)
                          : null;
                      final String department = formData['department'] ?? '';
                      final String usn = formData['usn'] ?? '';
                      final int? phone_number = formData['phone_number'] != null
                          ? int.tryParse(formData['phone_number']!)
                          : null;
                      final String email = formData['email'] ?? '';
                      final int? election_id = formData['election_id'] != null
                          ? int.tryParse(formData['election_id']!)
                          : null;

                      if (post_id == null ||
                          phone_number == null ||
                          election_id == null) {
                        // Handle the case where parsing fails
                        print('Invalid values entered.');
                        return;
                      }

                      final candidate = ManageCandidatesModel(
                        name: name,
                        semester: semester,
                        post_id: post_id,
                        department: department,
                        usn: usn,
                        phone_number: phone_number,
                        email: email,
                        election_id: election_id,
                        id: 0, // check it once
                      );

                      await DatabaseHelper.addCandidate(candidate);

                      // Refresh the state by popping the current screen
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
