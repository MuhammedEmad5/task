import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks/person_data_model.dart';

import 'App_colors.dart';
import 'app_functions.dart';
import 'default_button.dart';
import 'default_text_form_field.dart';
import 'get_person_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController uniqueIdController = TextEditingController();
  final TextEditingController nationalityIDController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextFormField(
                  controller: nameController,
                  inputType: TextInputType.name,
                  labelText: 'name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'name can\'t be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextFormField(
                  controller: birthDateController,
                  inputType: TextInputType.datetime,
                  labelText: 'birthDate',
                  prefixIcon: Icons.date_range,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'birthDate can\'t be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextFormField(
                  controller: nationalityIDController,
                  inputType: TextInputType.number,
                  labelText: 'nationalityID',
                  prefixIcon: Icons.insert_drive_file_outlined,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'nationalityID can\'t be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextFormField(
                  controller: ageController,
                  inputType: TextInputType.number,
                  labelText: 'age',
                  prefixIcon: Icons.class_outlined,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'age can\'t be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextFormField(
                  controller: uniqueIdController,
                  inputType: TextInputType.number,
                  labelText: 'uniqueId',
                  prefixIcon: Icons.important_devices_outlined,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'uniqueId can\'t be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                saveButton(),
                const SizedBox(height: 20),
                gatPersonsDataButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return isLoading
        ? const CircularProgressIndicator()
        : DefaultButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          isLoading = true;
          PersonDataModel model = PersonDataModel(
              name: nameController.text,
              uniqueId: uniqueIdController.text,
              age: ageController.text,
              nationalityID: nationalityIDController.text,
              birthDate: birthDateController.text);
          FirebaseFirestore.instance
              .collection('Persons')
              .add(model.toMap())
              .then((value) {
            setState(() {
              isLoading = false;
            });
            AppFunctions.showSnackBar(
                context, 'Person Data added successfully',
                error: false);
          });
        }
      },
      child: Text(
        'save',
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: AppColors.black),
      ),
    );
  }

  Widget gatPersonsDataButton() {
    return DefaultButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const GetPersonData()));
      },
      child: Text(
        'get person data',
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: AppColors.black),
      ),
    );
  }
}