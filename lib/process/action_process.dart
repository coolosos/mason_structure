library actions_process;

import 'dart:async';
import 'dart:io';

part 'custom_process.dart';
part 'key_replacement_process.dart';
part 'shell_process.dart';

sealed class ActionProcess {
  const ActionProcess({this.proccessName});

  final String? proccessName;
}





