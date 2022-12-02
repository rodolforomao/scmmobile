import 'package:flutter/material.dart';

import '../models/util_model/util_dropdown_list.dart';

double maxHeightAppBar(BuildContext context,double height) {
  return (MediaQuery.of(context).size.height - height) - MediaQuery.of(context).padding.top;
}


class Responsive {

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width >= 640;

  setMinHeightView(BuildContext context) {
    minHeightView  =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  }
  static double minHeightView = 1.1;
}
