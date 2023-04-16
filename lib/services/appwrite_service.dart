import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:get_storage/get_storage.dart';

class AppwriteService {
  ///  Local storage for storing session data
  static final GetStorage _storage = GetStorage();

  /// Appwrite service singleton
  AppwriteService._internal();

  static final AppwriteService _instance = AppwriteService._internal();

  factory AppwriteService() => _instance;

  /// Appwrite client
  static Client _client = Client();

  /// Appwrite account
  static Account _account = Account(_client);

  /// Appwrite session data
  static models.Session? _session = _storage.hasData('session')
      ? models.Session.fromMap(_storage.read('session'))
      : null;

  /// Appwrite contextual token
  static models.Token? _token;

  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  Future<models.Account> get account => _account.get();

  static bool get isLoggedIn => _session != null;

  /// Initializes the Appwrite service
  /// [endpoint] is the endpoint from the Appwrite console
  /// [projectId] is the project ID from the Appwrite console
  /// [selfSigned] is used to set the self signed certificate - default is true
  static Future<void> init({
    /// Endpoint from Appwrite console
    required String endpoint,

    /// Project ID from Appwrite console
    required String projectId,

    /// selfSigned is used to set the self signed certificate - default is true
    /// `true` only for development
    bool selfSigned = true,
  }) async {
    _isInitialized = true;
    _client
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: selfSigned);
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `user`: `Account` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> createEmailAccount({
    /// Email of the user to signup
    required String email,

    /// Password for the email
    required String password,

    /// Name of the user to signup
    String? name,
  }) async {
    try {
      final models.Account userAccount = await _account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );

      return userAccount.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `session`: `Session` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> loginEmailAccount({
    /// Email of the user to login
    required String email,

    /// Password for the email
    required String password,
  }) async {
    Account account = Account(_client);
    try {
      final models.Session session = await account.createEmailSession(
        email: email,
        password: password,
      );
      _session = session;
      _storage.write('session', session.toMap());
      return session.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `token`: `Token` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> resetEmailPassword({
    /// Email of the user to reset password
    required String email,
  }) async {
    Account account = Account(_client);

    try {
      final models.Token token = await account.createRecovery(
        email: email,
        url: 'https://dl-appwrite.loca.lt/reset-password',
      );

      _token = token;

      return token.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `token`: `Token` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> resetPassword({
    /// User ID
    required String userId,

    /// Secret token
    required String secret,

    /// Password for the email
    required String password,

    /// Password confirmation for the email
    required String passwordAgain,
  }) async {
    try {
      final models.Token token = await _account.updateRecovery(
        userId: _token!.userId,
        secret: _token!.secret,
        password: password,
        passwordAgain: passwordAgain,
      );

      return token.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `token`: `Token` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> createPhoneAccount({
    /// Phone number of the user to signup
    required String phone,

    /// Connect the phone number to an existing account
    bool connectMode = false,
  }) async {
    try {
      if (connectMode) {
        if (isLoggedIn) {
          final models.Token token = await _account.createPhoneSession(
            userId: _session!.userId,
            phone: phone,
          );
          return token.toMap();
        } else {
          throw AppwriteException(
            'You need to be logged in to connect a phone number',
            401,
            'No session found',
            null,
          );
        }
      }

      final models.Token token = await _account.createPhoneSession(
        userId: ID.unique(),
        phone: phone,
      );

      return token.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Returns a map with the following keys:
  /// if there was no error:
  /// - `session`: `Session` from Appwrite
  /// if there was an error:
  /// - `error`: `true` if there was an error
  /// - `type`: `error` if there was an error
  /// - `message`: `String` containing the error message
  /// - `code`: `int` containing the error code
  static Future<Map<String, dynamic>> updatePhoneSession({
    /// UserId from the token map from createPhoneAccount
    required String userId,

    /// Password for the phone
    required String secret,
  }) async {
    try {
      final models.Session session = await _account.updatePhoneSession(
        secret: secret,
        userId: userId,
      );

      return session.toMap();
    } on AppwriteException catch (e) {
      return {
        'error': true,
        'type': e.type,
        'message': e.message,
        'code': e.code,
      };
    }
  }

  /// Logs out the user
  /// Deletes the session from the Appwrite server
  /// Deletes the session from local storage
  Future<void> logout() async {
    if (_session == null) {
      return;
    } else {
      await _account.deleteSession(sessionId: _session!.$id);
      _session = null;
      _storage.remove('session');
    }
  }
}
