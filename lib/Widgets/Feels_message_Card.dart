import 'package:flutter/material.dart';
import '../Screens/edit_screen_Deals.dart';
import '../model/fealings_model.dart';

Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

class Feals_Widget extends StatefulWidget {
  Feel _feal;
  Feals_Widget(this._feal, {super.key});

  @override
  State<Feals_Widget> createState() => _Feals_WidgetState();
}

class _Feals_WidgetState extends State<Feals_Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              // image
              SizedBox(width: 25),
              // title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget._feal.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    time()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 28,
            decoration: BoxDecoration(
              color: custom_green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: Row(
                children: [
                  Image.asset('images/icon_time.png'),
                  SizedBox(width: 10),
                  Text(
                    widget._feal.time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
