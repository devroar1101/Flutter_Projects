import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/provider/user_provider.dart';

// ignore: must_be_immutable
class TagPeopleArea extends ConsumerWidget {
  TagPeopleArea({
    super.key,
    required this.connections,
    required this.taggedUsersIds,
    this.tagUser,
  });

  final List<String> connections;
  final List<String> taggedUsersIds;
  Function(bool, AppUser)? tagUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionUsersAsyncValue =
        ref.watch(userListFromIdsProvider(connections));
    return connectionUsersAsyncValue.when(
      data: (connectionUsers) {
        return ListView.builder(
          itemCount: connectionUsers.length,
          itemBuilder: (context, index) {
            final user = connectionUsers[index];
            final isTagged = taggedUsersIds.contains(user.userId);

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture),
              ),
              title: Text(user.username),
              trailing: IconButton(
                icon: Icon(
                  isTagged ? Icons.check_circle : Icons.add_circle_outline,
                  color: isTagged ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  if (tagUser == null) {
                    return;
                  }
                  tagUser!(isTagged, user);
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Text('Error loading connection users: $error'),
    );
  }
}
