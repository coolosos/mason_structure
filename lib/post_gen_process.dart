import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';

import 'process/action_process.dart';
import 'post_gen_actions.dart';

abstract class PostGenProcess {
  const PostGenProcess({
    required String filePath,
    required this.context,
  }) : _filePath = filePath;

  final String _filePath;
  final HookContext context;

  ///Must be call. Execute the modification to the path, save the file and format document.
  Future<void> run() async {
    final File file = File(_filePath);
    await preActions(
      generateFile: File(_filePath),
      stringFile: file.readAsStringSync(),
      vars: context.vars,
    );

    await PostGenActions(
      context: context,
      path: _filePath,
      actions: actions(
        context.vars,
      ),
    ).call();
  }

  List<ActionProcess> actions(Map<String, dynamic> vars);

  ///Could contains asserts or other customs actions.
  FutureOr<void> preActions({
    required File generateFile,
    required String stringFile,
    required Map<String, dynamic> vars,
  }) {}
}
