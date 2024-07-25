import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary(this.summary, {super.key});

  final List<Map<String, Object>> summary;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((data) {
            return Row(
              children: [
                Badge(
                  backgroundColor:
                      data['SubmitedAnswer'] == data['CorrectAnswer']
                          ? const Color.fromARGB(223, 83, 241, 88)
                          : const Color.fromARGB(223, 231, 86, 76),
                  largeSize: 50,
                  label: Text(
                    ((data['QuestionNo'] as int) + 1).toString(),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        data['Question'] as String,
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        data['CorrectAnswer'] as String,
                        style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 4, 211, 49),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['SubmitedAnswer'] as String,
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
