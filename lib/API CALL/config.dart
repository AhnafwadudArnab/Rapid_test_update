class AppConfig {
  // Development server URLs
  static const String localBaseUrl = 'http://127.0.0.1:8000/';
  static const String localApiUrl = 'http://127.0.0.1:8000/api/';

  static const String ngrokBaseUrl =
      'https://84fa405b7d87.ngrok-free.app/';
  static const String ngrokApiUrl =
      'https://84fa405b7d87.ngrok-free.app/api/';
  // Use this to switch between local and ngrok
  static const bool useNgrok = true;

  // Get the appropriate base URL based on configuration
  static String get baseUrl => useNgrok ? ngrokBaseUrl : localBaseUrl;
  static String get apiUrl => useNgrok ? ngrokApiUrl : localApiUrl;

  // API endpoints
  static String get testDetectUrl => '${apiUrl}test-detect/';
  static String get testsUrl => '${apiUrl}tests/';
  static String get adminLoginUrl => '${baseUrl}admin/login/?next=/admin/';

  // Test result URL template
  static String getTestResultUrl(String resultPath) =>
      '${baseUrl}rapid_tests/test-result/$resultPath/';
}
