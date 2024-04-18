import 'package:flutter/material.dart';

import '../controller/control_type_controller.dart';
import '../model/entity/control_type_entity.dart';
import 'group_page.dart';

/*class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ControlTypeEntity> controlTypes = ControlTypeController().groups;
    const title = 'Subjects';
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: buildAppBar(title),
          body: Builder(
              builder: (BuildContext context) {
                return ListView.builder(
                  itemCount: controlTypes.length,
                  itemBuilder: (context, index) {
                    return GroupList(
                        controlTypes[index].name ?? "",
                        controlTypes[index].title ?? ""
                    );
                  },
                );
              }),
      ),
    );
  }*/

  /*FutureBuilder<List<Control_type>> buildFutureBuilder() {
    return FutureBuilder(
          future: ControlTypeSynchronizationService.getControlTypes(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return SubjectList(snapshot.data?[index].name ?? "");
                }
            );
          },
        );
  }*/

  /*AppBar buildAppBar(String title) {
    return AppBar(
          title: Text(title),
          backgroundColor: Colors.green,
        );
  }
}

class SubjectList extends StatelessWidget {
  const SubjectList(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
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
}*/