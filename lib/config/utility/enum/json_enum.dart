enum JsonEnum {
  find('find'),
  done('done'),
  splash('splash'),
  ;

  final String value;
  const JsonEnum(this.value);

  String get getPath => 'assets/json/$value.json';
}
