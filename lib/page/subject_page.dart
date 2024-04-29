import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';

import '../controller/subject_controller.dart';
import '../model/entity/subject_entity.dart';
import 'teacher/group_page.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SubjectPageState();
  }
}

class SubjectPageState extends State<SubjectPage> {
  Future<List<SubjectEntity>>? subjects;

  @override
  void initState() {
    super.initState();
    subjects = SubjectController().subjects;
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Предметы';
    return Scaffold(
        appBar: buildAppBar(title),
        body: buildFutureBuilder());
  }

  FutureBuilder<List<SubjectEntity>> buildFutureBuilder() {
    return FutureBuilder(
        future: subjects,
        builder: (context, snapshot) {
          return buildListView(snapshot);
        },
      );
  }

  ListView buildListView(AsyncSnapshot<List<SubjectEntity>> snapshot) {
    if (snapshot.data == null || snapshot.data?.length == 0) {
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text("Нет данных"),
            );
          }
      );
    } else {
      return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return SubjectList(snapshot.data?[index].name ?? "");
          });
    }
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      backgroundColor: appbarColor,
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () => synchronization(),
          icon: const Icon(Icons.access_time),
        )
      ],
    );
  }

  synchronization() {
    SubjectController().synchronization().then((_) => {
          setState(() {
            subjects = SubjectController().subjects;
          })
        });
  }
}

class SubjectList extends StatelessWidget {
  const SubjectList(this.name, {super.key});
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GroupPage(),
          ),
        );
      },
    );
  }
}
