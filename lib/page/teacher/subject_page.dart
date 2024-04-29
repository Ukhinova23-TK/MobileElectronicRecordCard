import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/page/teacher/group_page.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SubjectPageState();
  }
}

class SubjectPageState extends State<SubjectPage> {
  Future<List<SubjectEntity>>? subjects;
  final searchText = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    subjects = SubjectController().subjects;
  }

  @override
  Widget build(BuildContext context) {
    const title = titleSubjectPage;
    return Scaffold(
        appBar: AppBarWithSearchSwitch(
          onChanged: (text) {
            searchText.value = text;
            setState(() {
              subjects = SubjectController().subjects;
            });
          },
          appBarBuilder: (context) {
            return AppBar(
              backgroundColor: appbarColor,
              title: const Text(title),
              actions: [
                const AppBarSearchButton(
                  buttonHasTwoStates: false,
                ),
                IconButton(
                  onPressed: () => synchronization(),
                  icon: const Icon(Icons.access_time),
                )
              ],
            );
          },
        ),
        body: buildFutureBuilder()
    );
  }

  FutureBuilder<List<SubjectEntity>> buildFutureBuilder() {
    return FutureBuilder(
      future: subjects,
      builder: (context, snapshot) {
        return search(snapshot);
      },
    );
  }

  ListView search (AsyncSnapshot<List<SubjectEntity>> snapshot) {
    List<SubjectEntity> list = [];
    if(searchText.value == ''){
      snapshot.data?.forEach((e) => list.add(e));
      return buildListView(list);
    }
    if(snapshot.hasData){
      snapshot.data?.forEach((e) {
        if(e.name!.toLowerCase().contains(searchText.value.toLowerCase())) {
          list.add(e);
        }
      });
    }
    return buildListView(list);
  }

  ListView buildListView(List<SubjectEntity> snapshot) {
    if (snapshot.isEmpty) {
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text("Нет данных"),
            );
          });
    } else {
      return ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            return SubjectList(snapshot[index].name ?? "");
          }
      );
    }
  }

  synchronization() {
    SubjectController().synchronization().then((_) =>
    {
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
