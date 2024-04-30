import 'dart:io';

import '../process/action_process.dart';

final class CommandLineAction extends ShellProcess {
  CommandLineAction(
    super.shellCommand,
  );

  @override
  Future<void> call() async {
    await Process.run(
      splitCommand.removeAt(0),
      splitCommand,
    );
  }
}
