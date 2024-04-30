import '../process/action_process.dart';

final class KeyChangeAllOcurrencesAction extends KeyReplacementeProcess {
  const KeyChangeAllOcurrencesAction({
    required this.key,
    required this.to,
    super.proccessName,
  });

  final String key;
  final String to;

  @override
  String run(String stringFile) {
    return stringFile.replaceAll(genKey(key), to);
  }
}
