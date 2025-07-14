// ignore_for_file: non_constant_identifier_names

class Server {
  static const String base_url = 'http://127.0.0.1:8000/';
  static const String api = 'api/';
  static const String test = 'tests/';
  static const String test_ditect = 'test-detect/';
  static const String slug = 'slug';
  static const String image = '/?Image';

  // API endpoint for image upload
  static const String analysis_check =
      'http://127.0.0.1:8000/api/test-detect/$slug/'; // POST image   http://127.0.0.1:8000/api/test-detect/covid19_c-19/

  // API endpoint for updating an element
  static const String update_element =
      '$base_url$api$test_ditect$slug/update'; // PUT request for updating an element

  // API endpoint for adding a new element
  static const String add_element =
      '$base_url$api$test_ditect$slug/add'; // POST request for adding a new element

  // API endpoint for test detection
  static const String Finalreport =
      '$base_url$api$test_ditect$slug$image'; // GET request for test detection
  // API endpoint for test list
  static const String info_tests =
      '$base_url$api$test'; // GET request for test list
}

//serverAPI from ngrok is here.. //
class ServiceAPI {
  String Ngrok_server = 'https://84fa405b7d87.ngrok-free.app/';
  String Ngrok_server_api = 'https://84fa405b7d87.ngrok-free.app/api/';
  String Ngrok_server_test = 'https://84fa405b7d87.ngrok-free.app/api/tests/';
  String Ngrok_server_test_ditect =
      'https://84fa405b7d87.ngrok-free.app/api/test-detect/';
  String Ngrok_server_image =
      'https://84fa405b7d87.ngrok-free.app/api/test-detect/slug/?Image';
  String test_result =
      "https://84fa405b7d87.ngrok-free.app/rapid_tests/test-result/none-c19-ahnaf-2025-04-05-21-05-22-529615-00-00/";
  String Ngrok_server_admin_login =
      'https://84fa405b7d87.ngrok-free.app/admin/login/?next=/admin/';
}
