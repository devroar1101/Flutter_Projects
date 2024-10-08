import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/people/tag_people_area.dart';

// ignore: must_be_immutable
class TagPeople extends ConsumerStatefulWidget {
  TagPeople({
    super.key,
    required this.connections,
    required this.taggedUsersIds,
    required this.tagUser,
  });

  final List<String> connections;
  final List<String> taggedUsersIds;
  Function(String, String) tagUser;

  @override
  ConsumerState<TagPeople> createState() => _TagPeopleState();
}

class _TagPeopleState extends ConsumerState<TagPeople> {
  List<String> taggedUserIds = [];

  @override
  void initState() {
    super.initState();
    taggedUserIds = widget.taggedUsersIds;
  }

  void tag(isTagged, user) {
    setState(() {
      if (isTagged) {
        widget.tagUser(user.userId, 'remove');
      } else {
        widget.tagUser(user.userId, 'add');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tag people'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TagPeopleArea(
                connections: widget.connections,
                taggedUsersIds: widget.taggedUsersIds,
                tagUser: tag)));
  }
}
