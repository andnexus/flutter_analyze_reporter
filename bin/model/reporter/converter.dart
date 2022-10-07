import '../issue.dart';

abstract class Convert<T> {
  List<T> convert(List<Issue> issues);

  List<String> categories(String type);

  String severity(String type);
}
