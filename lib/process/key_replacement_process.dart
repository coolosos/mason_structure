part of 'action_process.dart';

abstract class KeyReplacementeProcess extends ActionProcess {
  const KeyReplacementeProcess({
    super.proccessName,
  });

  String run(String stringFile);

  RegExp genKey(String key) {
    final String customRegex = r'\$gen\({key}\)'.replaceFirst('{key}', key);
    return RegExp(customRegex);
  }
}
