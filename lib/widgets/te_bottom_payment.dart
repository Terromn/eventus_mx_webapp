import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/utlis/get_info_helper.dart';
import 'package:flutter/material.dart';

class TeBottomPaymentScreen extends StatefulWidget {
  const TeBottomPaymentScreen({super.key});

  @override
  State<TeBottomPaymentScreen> createState() => _TeBottomPaymentScreenState();
}

class _TeBottomPaymentScreenState extends State<TeBottomPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        color: TeAppColorPalette.black,
      ),
      height: TeInformationUtil.getPercentageHeight(context, 100),
      child: const Center(
        child: Text('TODO'),
      ),
    );
  }
}
