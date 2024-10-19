import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/provider/user_provider.dart';

// ignore: must_be_immutable
class SplitList extends ConsumerWidget {
  SplitList(
      {super.key,
      required this.connections,
      required this.paidUsers,
      this.tagUser,
      this.perPerson,
      this.post,
      this.split,
      this.updatePaidUser});

  final List<String> connections;
  final List<String> paidUsers;
  Function(bool, AppUser)? tagUser;
  double? perPerson;
  SplitWise? split;
  Post? post;
  Function(SplitWise, String, String)? updatePaidUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionUsersAsyncValue =
        ref.watch(userListFromIdsProvider(connections));

    // double splitAmount = 0.0;

    // if (amount != null) {
    //   splitAmount = double.tryParse(amount!) ?? 0.0;
    // }

    return connectionUsersAsyncValue.when(
      data: (connectionUsers) {
        return ListView.builder(
          itemCount: connectionUsers.length,
          itemBuilder: (context, index) {
            final user = connectionUsers[index];
            final isPaid = paidUsers.contains(user.userId);

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture),
              ),
              title: Text(user.username),
              trailing: perPerson == null
                  ? IconButton(
                      icon: Icon(
                        isPaid ? Icons.check_circle : Icons.add_circle_outline,
                        color: isPaid ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        if (tagUser == null) {
                          return;
                        }
                        tagUser!(isPaid, user);
                      },
                    )
                  : GestureDetector(
                      onTap: () {
                        splitUserUpdate(updatePaidUser!, isPaid, user, split!,
                            perPerson!, context);
                      },
                      child: Text(
                        '₹ $perPerson',
                        style: GoogleFonts.poppins(
                            color: isPaid ? Palette.online : Palette.unPaid,
                            fontSize: 18),
                      ),
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

void splitUserUpdate(
    Function(SplitWise split, String userId, String type) updatePaidDetail,
    bool isPaid,
    AppUser user,
    SplitWise split,
    double perPerson,
    context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: AlertDialog(
            title: Wrap(
              children: [
                Text(
                  '${user.username} paid ₹ $perPerson ?',
                  style: GoogleFonts.poppins(
                      color: Colors.grey[800], fontSize: 20),
                ),
              ],
            ),
            content: SizedBox(
              height: 50,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        updatePaidDetail(
                            split, user.userId, isPaid ? 'remove' : 'add');
                        Navigator.pop(context);
                      },
                      child: Text(
                        isPaid ? 'UnPaid' : 'Paid',
                        style: GoogleFonts.poppins(
                            color: Colors.grey[700], fontSize: 18),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'cancel',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[700], fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
