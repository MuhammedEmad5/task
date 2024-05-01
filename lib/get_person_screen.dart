
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/person_data_model.dart';

import 'app_functions.dart';

class GetPersonData extends StatefulWidget {
  const GetPersonData({super.key});

  @override
  State<GetPersonData> createState() => _GetPersonDataState();
}

class _GetPersonDataState extends State<GetPersonData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonsData();
    getPersonsUIds();
  }

  List<PersonDataModel> personsData = [];
  List<String>id=[];

  Future<void> getPersonsData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('Persons').get();
    personsData.clear();
    for (var element in querySnapshot.docs) {
      setState(() {
        personsData.add(PersonDataModel.fromJson(element.data()));
      });
    }
  }

  Future<void> getPersonsUIds()async {
    QuerySnapshot<Map<String, dynamic>>snapShot = await FirebaseFirestore.instance
        .collection('Persons')
        .get();
    snapShot.docs.forEach((element) {
      setState(() {
        id.add(element.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('persons data'),
      ),
      body: personsData.isEmpty || id.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemBuilder: (context, index) => itemBuilder(personsData[index],id[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: personsData.length,
      ),
    );
  }

  Widget itemBuilder(PersonDataModel model,uId) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Persons')
                        .doc(uId)
                        .delete().then((value) {
                      getPersonsData();
                      getPersonsUIds();
                      AppFunctions.showSnackBar(context, 'person data deleted successfully', error: false);
                      setState(() {

                      });
                    });

                  },

                  icon: Icon(Icons.delete)
              )

            ],
          ),
          Text(model.name!),
          const SizedBox(
            height: 10,
          ),
          Text(model.age!),
          const SizedBox(
            height: 10,
          ),
          Text(model.uniqueId!),
          const SizedBox(
            height: 10,
          ),
          Text(model.birthDate!),
          const SizedBox(
            height: 10,
          ),
          Text(model.nationalityID!),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}