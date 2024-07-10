import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';

class Accordion extends StatefulWidget {
  final String title;
  // bool areAllfieldsNonEmpty;
  Accordion({
    Key? key,
    required this.title,
    required this.onClick,
    required this.showContent,
    // required this.areAllfieldsNonEmpty
  }) : super(key: key);
  bool showContent;

  Widget onClick;
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // bool widget.showContent = false;
  //bool areAllfieldsNonEmpty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(children: [
          ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            tileColor: widget.showContent ? Colors.white : Color(0xFFFEE8D6),
            title: Text(
              widget.title,
              style: getTextTheme().headlineMedium,
            ),
            trailing:
                //  areAllfieldsNonEmpty ? Icon(Icons.check) : Icon(Icons.clear),
                IconButton(
              icon: Icon(
                //  areAllfieldsNonEmpty ? Icon(Icons.check) : Icon(Icons.clear)

                widget.showContent ? (Icons.remove_rounded) : Icons.add_rounded,
                color: ConstColors.textColor,
              ),
              onPressed: () {
                // setState(() {
                //   //  return widget.onClick();
                //   widget.showContent = !widget.showContent;
                // });
              },
            ),
            onTap: () {
              // setState(() {
              //   //  return widget.onClick();
              //   widget.showContent = !widget.showContent;
              // });
            },
          ),
          widget.showContent
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            10,
                          ),
                          bottomRight: Radius.circular(10))),
                  child: widget.onClick,
                )
              : Container()
        ]),
      ),
    );
  }
}
