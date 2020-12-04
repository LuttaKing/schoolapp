

import 'package:flutter/material.dart';

class MyNotifier extends ChangeNotifier{

  bool meeting_on=false;

    set_meeting()async{
    meeting_on=!meeting_on;
    notifyListeners();

    }

}