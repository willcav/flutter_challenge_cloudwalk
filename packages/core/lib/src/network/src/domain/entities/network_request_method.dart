enum NetworkRequestMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String name;

  const NetworkRequestMethod(this.name);
}
