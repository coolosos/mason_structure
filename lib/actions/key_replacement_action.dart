import '../process/action_process.dart';

final class KeyReplacementAction extends KeyReplacementeProcess {
  const KeyReplacementAction({
    required this.key,
    required this.to,
    super.proccessName,
  });

  final String key;
  final String to;

  @override
  String run(String stringFile) {
    return stringFile.replaceFirst(genKey(key), to);
  }
}
