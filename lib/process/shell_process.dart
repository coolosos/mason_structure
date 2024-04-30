part of 'action_process.dart';

abstract class ShellProcess extends ActionProcess {
  ShellProcess(
    this.shellCommand,
  )   : splitCommand = shellCommand.split(' '),
        assert(
          shellCommand.isNotEmpty &&
              shellCommand.contains(RegExp(r"[a-zA-Z]{2,}\s[a-zA-Z]{2,}")),
        );

  final String shellCommand;
  final List<String> splitCommand;

  Future<void> call();
}
