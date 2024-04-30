import 'dart:io';

import '../process/action_process.dart';

final class ShellAction extends ShellProcess {
  ShellAction(
    super.shellCommand,
  );

  @override
  Future<void> call() async {
    await Process.start(
      splitCommand.removeAt(0),
      splitCommand,
      runInShell: true,
      mode: ProcessStartMode.inheritStdio,
    );
  }
}
