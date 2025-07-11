import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/config/constants/shared_pref_constants.dart';

/// A singleton utility class that manages access to shared preferences
/// for persisting and retrieving application data, specifically the task list.
class SharedPreferenceUtil {
  /// Private constructor that initializes the [SharedPreferencesAsync] instance.
  SharedPreferenceUtil._() {
    sharedPreferences = SharedPreferencesAsync();
  }

  /// Internal singleton instance of [SharedPreferenceUtil].
  static SharedPreferenceUtil get _instance => SharedPreferenceUtil._();

  /// Factory constructor that returns the singleton instance.
  factory SharedPreferenceUtil() => _instance;

  /// The instance of [SharedPreferencesAsync] used for reading/writing preferences.
  late final SharedPreferencesAsync sharedPreferences;

  /// Persists the JSON-encoded task list string to shared preferences.
  ///
  /// [jsonEncodedTodoList] is the string-ified version of the task list data
  /// to be stored under a specific key.
  Future<void> updateTodos(String jsonEncodedTodoList) => sharedPreferences.setString(
    SharedPrefConstants.kTodoListResponseKey,
    jsonEncodedTodoList,
  );

  /// Retrieves the saved JSON-encoded task list string from shared preferences.
  ///
  /// Returns the encoded string if available, otherwise `null`.
  Future<String?> get getTodos => sharedPreferences.getString(
    SharedPrefConstants.kTodoListResponseKey,
  );
}
