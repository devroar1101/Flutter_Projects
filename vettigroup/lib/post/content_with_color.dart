import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/data/data.dart';

// ignore: must_be_immutable
class ContentWithColor extends StatefulWidget {
  ContentWithColor(
      {super.key,
      required this.contentController,
      required this.setContentColor,
      this.contentColor,
      this.contentFontColor});

  TextEditingController contentController;

  void Function(String, String) setContentColor;

  String? contentColor, contentFontColor;

  @override
  State<ContentWithColor> createState() => ContentWithColorState();
}

class ContentWithColorState extends State<ContentWithColor> {
  final colorList = colors;
  final fontColorList = fontColors;
  var color = '0xffffffff';
  var fontcolor = '0xff000000';
  var index = 0;
  var fontIndex = 1;

  @override
  void initState() {
    super.initState();
    if (widget.contentColor != null &&
        widget.contentFontColor != null &&
        widget.contentColor != '' &&
        widget.contentFontColor != '') {
      color = widget.contentColor!;
      fontcolor = widget.contentFontColor!;
      index = colorList.indexWhere(
        (color) => color == widget.contentColor!,
      );
      fontIndex = fontColorList.indexWhere(
        (color) => color == widget.contentFontColor!,
      );
    }
    widget.setContentColor(color.toString(), fontcolor.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 300,
            width: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(int.parse(color.replaceFirst('0x', ''), radix: 16)),
            ),
            child: Center(
              child: TextField(
                controller: widget.contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "What's on your mind?",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Color(int.parse(fontcolor.replaceFirst('0x', ''),
                            radix: 16))),
                    fillColor: Color(
                        int.parse(color.replaceFirst('0x', ''), radix: 16)),
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    counterText: ''),
                showCursor: true,
                style: TextStyle(
                    fontSize: 25,
                    color: Color(int.parse(fontcolor.replaceFirst('0x', ''),
                        radix: 16))),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colorList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(int.parse(
                              colorList[index].replaceFirst('0x', ''),
                              radix: 16)),
                          shape: BoxShape.circle,
                          border: Border.all(color: Palette.vettiGroupColor)),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              this.index = index;
                              color = colorList[index];
                              widget.setContentColor(color, fontcolor);
                            });
                          },
                          icon: this.index == index
                              ? Icon(
                                  Icons.check,
                                  color: Palette.vettiGroupColor,
                                )
                              : const SizedBox.shrink()),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fontColorList.length,
              itemBuilder: (BuildContext context, int index) {
                return IconButton(
                    onPressed: () {
                      setState(() {
                        fontIndex = index;
                        fontcolor = fontColorList[index];
                        widget.setContentColor(color, fontcolor);
                      });
                    },
                    icon: Icon(
                      Icons.font_download_outlined,
                      color: index == 0
                          ? Colors.grey[200]
                          : Color(int.parse(
                              fontColorList[index].replaceFirst('0x', ''),
                              radix: 16)),
                      size: fontIndex == index ? 50 : 30,
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
