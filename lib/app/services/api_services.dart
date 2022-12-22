abstract class ApiServices {
  Future<dynamic> get(String path, {Map<String, dynamic>? query});

  Future<dynamic> post(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? query});

  Future<dynamic> put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? query});
}
