import 'package:flutter/material.dart';

bool isMediumScreenMenu(BuildContext context) {
  return MediaQuery.of(context).size.width > 500;
}
