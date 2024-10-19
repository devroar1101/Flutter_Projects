import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/people/split_list.dart';

// ignore: must_be_immutable
class ContentWithSplit extends StatelessWidget {
  ContentWithSplit(
      {super.key,
      required this.contentController,
      required this.amountController,
      required this.user,
      required this.tagUser,
      required this.taggedUser,
      this.splitDate,
      required this.updateDate});

  TextEditingController contentController;
  TextEditingController amountController;
  final AppUser user;
  final Function(String, String) tagUser;
  final List<String> taggedUser;
  DateTime? splitDate;
  void Function() updateDate;

  @override
  Widget build(BuildContext context) {
    void tag(isTagged, user) {
      if (isTagged) {
        tagUser(user.userId, 'remove');
      } else {
        tagUser(user.userId, 'add');
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.white,
            shadowColor: Palette.vettiGroupColor,
            child: Column(
              children: [
                TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Bill Details!",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 20, color: Colors.grey[700]),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: IconButton(
                      onPressed: updateDate,
                      icon: splitDate == null
                          ? const Icon(
                              Icons.calendar_month,
                              size: 30,
                            )
                          : Text(
                              '- ${DateFormat('dd MMM yyyy').format(splitDate!)}',
                              style: GoogleFonts.poppins(
                                  fontSize: 10, color: Colors.grey[800]),
                            ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.grey[800]),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: amountController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.grey[700]),
                  showCursor: true,
                ),
              ],
            ),
          ),
          Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SplitList(
                connections: user.connections,
                paidUsers: taggedUser,
                tagUser: tag,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
