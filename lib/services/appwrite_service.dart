class AppwriteAuth {
  AppwriteAuth._internal();
  static final AppwriteAuth _instance = AppwriteAuth._internal();

  factory AppwriteAuth() => _instance;

  /// Endpoint from Appwrite console
  static String? _endpoint;

  /// Project ID from Appwrite console
  static String? _projectId;

  /// selfSigned is used to set the self signed certificate - default is true
  /// `true` only for development
  static bool _selfSigned = true;

  static bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  static void init({
    /// Endpoint from Appwrite console
    required String endpoint,

    /// Project ID from Appwrite console
    required String projectId,

    /// selfSigned is used to set the self signed certificate - default is true
    /// `true` only for development
    bool selfSigned = true,
  }) {
    _endpoint = endpoint;
    _projectId = projectId;
    _selfSigned = selfSigned;
    _isInitialized = true;
  }
}
