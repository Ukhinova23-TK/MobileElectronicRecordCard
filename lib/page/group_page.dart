import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GroupPageState();
  }
  
}

class GroupPageState extends State<GroupPage>{
  Future<List<ControlTypeEntity>>? groups;

  @override
  void initState() {
    super.initState();
    groups = ControlTypeController().groups;
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Группы';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: groups,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GroupList(
                    snapshot.data?[index].name ?? "",
                    snapshot.data?[index].title ?? ""
                );
              }
          );
        },
      )
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList(this.name, this.title, {super.key});
  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}