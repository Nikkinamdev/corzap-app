import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controller/pincontroller.dart';

class CustomPin extends StatefulWidget {
  final List<TextEditingController> controllers;

  const CustomPin({super.key, required this.controllers});

  @override
  State<CustomPin> createState() => _CustomPinState();
}

class _CustomPinState extends State<CustomPin> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (_) => FocusNode());

    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: w * .12,
          height: w * .12,
          child: TextFormField(
            controller: widget.controllers[index],
            focusNode: _focusNodes[index],

            textInputAction:
            index < 3 ? TextInputAction.next : TextInputAction.done,

            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: w * .02),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * .03),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsList.mainButtonColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(w * .03),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.controllers[index].text.isNotEmpty
                      ? ColorsList.mainButtonColor
                      : Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(w * .03),
              ),
            ),

            style: TextStyle(
              fontSize: w * .04,
              fontWeight: FontWeight.w500,
            ),

            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,

            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        );
      }),
    );
  }
}


