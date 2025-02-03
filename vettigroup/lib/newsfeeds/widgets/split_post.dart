import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/people/split_list.dart';
import 'package:vettigroup/provider/split_provider.dart';
import 'package:vettigroup/widgets/loader.dart';

// ignore: must_be_immutable
class SplitPost extends ConsumerStatefulWidget {
  SplitPost({super.key, required this.post, required this.updateSplit});

  final Post post;
  Function(SplitWise) updateSplit;

  @override
  ConsumerState<SplitPost> createState() => _SplitPostState();
}

class _SplitPostState extends ConsumerState<SplitPost> {
  SplitWise? split;

  void updateSplitPaidUser(SplitWise split, String userId, String type) {
    if (type == 'add') {
      split.paidUser.add(userId);
    } else {
      split.paidUser.remove(userId);
    }

    setState(() {});
  }

  void updateSplitParameter(SplitWise split) {
    ref.read(splitNotifier.notifier).updateSplit(split);
  }

  @override
  Widget build(BuildContext context) {
    final splitAsynValue = ref.watch(getSplitDetail(widget.post.id));

    return splitAsynValue.when(
        data: (split) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Code to execute after the build is complete
            updateSplitParameter(split!);
          });

          return FlipCard(
            fill: Fill.fillBack,
            front: Container(
              color: Colors.grey[100],
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Expanded(
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            widget.post.content,
                            style: GoogleFonts.poppins(
                                color: Colors.grey[800], fontSize: 20),
                          ),
                          Text(
                            ' - ${DateFormat('dd-MM-yyyy,').format(split!.splitDate.toDate())}',
                            style: GoogleFonts.poppins(
                                color: Colors.grey[700], fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          totalAmount(split, widget.post),
                          totalPaidProgress(split, widget.post, 1)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            back: SizedBox(
              child: Expanded(
                child: Column(
                  children: [
                    totalPaidProgress(split, widget.post, 2),
                    Expanded(
                      child: SplitList(
                        connections: widget.post.taggedUsers,
                        paidUsers: split.paidUser,
                        perPerson: perperson(split, widget.post),
                        split: split,
                        updatePaidUser: updateSplitPaidUser,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (e, t) => Text('error $e'),
        loading: () {
          return const Loader(type: 2);
        });
  }
}

Widget totalAmount(SplitWise split, Post post) {
  final perPerson = perperson(split, post);

  return Card(
    shadowColor: Palette.vettiGroupColor,
    elevation: 3,
    child: SizedBox(
      height: 160,
      width: 160,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style:
                    GoogleFonts.poppins(color: Colors.grey[500], fontSize: 15),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '₹ ${split.amount}',
                style:
                    GoogleFonts.poppins(color: Colors.grey[800], fontSize: 30),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '₹ $perPerson',
                    style: GoogleFonts.poppins(
                        color: Colors.grey[700], fontSize: 18),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'per person',
                    style: GoogleFonts.poppins(
                        color: Colors.grey[600], fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget totalPaidProgress(SplitWise split, Post post, type) {
  final paid = totalPaid(split, post);
  final progressPercentage = paid / split.amount;
  double height = type == 1 ? 160 : 40;
  double width = type == 1 ? 160 : double.infinity;

  return Card(
      shadowColor: Palette.vettiGroupColor,
      elevation: 3,
      child: Expanded(
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: type == 1
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        strokeWidth: 10,
                        value: progressPercentage,
                        color: Palette.vettiGroupColor,
                      )
                    : LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        minHeight: 20,
                        borderRadius: BorderRadius.circular(12),
                        value: progressPercentage,
                        color: Palette.vettiGroupColor,
                        semanticsLabel: '₹ ${split.amount}',
                      ),
              ),
            ),
            if (type == 1)
              Positioned(
                  bottom: 65,
                  left: 0,
                  right: 0,
                  child: progressPercentage == 1.0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Done',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                            Icon(
                              Icons.done,
                              color: Palette.vettiGroupColor,
                              size: 50,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Paid',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                            Text(
                              paid != 0 ? '₹ ${paid.toString()}' : '0',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey[800],
                                  fontSize: paid != 0 ? 18 : 25),
                            ),
                          ],
                        )),
            if (type != 1)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: Text(
                    paid != 0
                        ? '₹ ${paid.toString()} / ₹ ${split.amount}'
                        : '0 / ₹ ${split.amount}',
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ));
}

double perperson(SplitWise split, Post post) {
  return split.amount / post.taggedUsers.length;
}

double totalPaid(SplitWise split, Post post) {
  return perperson(split, post) * split.paidUser.length;
}

void updateSplitPaidUser(Split split, String userId) {}
