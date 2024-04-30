import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';

import 'process/action_process.dart';
import 'actions/command_line_action.dart';

final class PostGenActions {
  PostGenActions({
    required String path,
    required this.actions,
    required this.context,
  }) : file = File(path);

  final File file;
  final List<ActionProcess> actions;
  final HookContext context;

  Future<void> call() async {
    String stringFile = file.readAsStringSync();

    for (ActionProcess action in actions) {
      final String data = switch (action) {
        CustomProcess() =>
          await _onCustomActions(action, stringFile: stringFile),
        KeyReplacementeProcess() =>
          _onKeyReplacementActions(action, stringFile),
        ShellProcess() => await _onShellActions(action, stringFile: stringFile)
      };

      stringFile = data;
    }

    file.writeAsStringSync(stringFile);
    final filePath = file.path;

    if (filePath.contains('.dart')) {
      await CommandLineAction('dart format ${file.path}').call();
    }
  }

  String _onKeyReplacementActions(
    KeyReplacementeProcess action,
    String stringFile,
  ) {
    Progress? process = _progressCreation(action);
    final data = action.run(stringFile);
    process?.complete();
    return data;
  }

  Future<String> _onShellActions(
    ShellProcess action, {
    required String stringFile,
  }) async {
    await action.call();
    return stringFile;
  }

  Future<String> _onCustomActions(
    CustomProcess action, {
    required String stringFile,
  }) async {
    Progress? process = _progressCreation(action);
    file.writeAsStringSync(stringFile);
    final newFile = await action.run(file);
    process?.complete();
    return newFile.readAsStringSync();
  }

  Progress? _progressCreation(ActionProcess actionProcess) {
    final processName = actionProcess.proccessName;
    Progress? process;
    if (processName != null && processName.isNotEmpty) {
      process = context.logger.progress(processName);
    }
    return process;
  }
}
