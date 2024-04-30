part of 'action_process.dart';

abstract class CustomProcess extends ActionProcess {
  const CustomProcess({
    super.proccessName,
  });
  FutureOr<File> run(File file);
}
