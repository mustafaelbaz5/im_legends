
// import 'package:shared_preferences/shared_preferences.dart';
// class SharedPrefStorage {
//   SharedPrefStorage._();
//   static final SharedPrefStorage instance = SharedPrefStorage._();

//   late final SharedPreferences _prefs;
//   bool _initialized = false;

//   /// ---------------------------
//   /// Initialize SharedPreferences (call once in main)
//   /// ---------------------------
//   Future<void> init() async {
//     if (_initialized) return;
//     _prefs = await SharedPreferences.getInstance();
//     _initialized = true;
//   }

//   void _checkInit() {
//     if (!_initialized) {
//       throw Exception('SharedPrefs not initialized. Call init() first.');
//     }
//   }

//   /// ---------------------------
//   /// Basic getters/setters
//   /// ---------------------------
//   Future<bool> setString(String key, String value) async {
//     _checkInit();
//     return _prefs.setString(key, value);
//   }

//   String? getString(String key) {
//     _checkInit();
//     return _prefs.getString(key);
//   }

//   Future<bool> setBool(String key, bool value) async {
//     _checkInit();
//     return _prefs.setBool(key, value);
//   }

//   bool? getBool(String key) {
//     _checkInit();
//     return _prefs.getBool(key);
//   }

//   Future<bool> setInt(String key, int value) async {
//     _checkInit();
//     return _prefs.setInt(key, value);
//   }

//   int? getInt(String key) {
//     _checkInit();
//     return _prefs.getInt(key);
//   }

//   Future<bool> setDouble(String key, double value) async {
//     _checkInit();
//     return _prefs.setDouble(key, value);
//   }

//   double? getDouble(String key) {
//     _checkInit();
//     return _prefs.getDouble(key);
//   }

//   Future<bool> setStringList(String key, List<String> value) async {
//     _checkInit();
//     return _prefs.setStringList(key, value);
//   }

//   List<String>? getStringList(String key) {
//     _checkInit();
//     return _prefs.getStringList(key);
//   }

//   /// ---------------------------
//   /// Notification-specific methods (scoped by userId)
//   /// ---------------------------

//   // Future<bool> setNotifications(
//   //   String userId,
//   //   List<NotificationModel> notifications,
//   // ) async {
//   //   _checkInit();
//   //   final jsonList = notifications.map((n) => json.encode(n.toJson())).toList();
//   //   return _prefs.setStringList('notifications_$userId', jsonList);
//   // }

//   // List<NotificationModel> getNotifications(String userId) {
//   //   _checkInit();
//   //   final jsonList = _prefs.getStringList('notifications_$userId') ?? [];
//   //   return jsonList
//   //       .map(
//   //         (jsonString) => NotificationModel.fromJson(json.decode(jsonString)),
//   //       )
//   //       .toList();
//   // }

//   /// Remove all notifications for a specific user
//   // Future<bool> clearUserNotifications(String userId) async {
//   //   _checkInit();
//   //   return _prefs.remove('notifications_$userId');
//   // }

//   /// Deduplicate notifications by id for a specific user
//   // Future<void> removeDuplicateNotifications(String userId) async {
//   //   final notifications = getNotifications(userId);
//   //   final unique = {for (var n in notifications) n.id: n}.values.toList();
//   //   await setNotifications(userId, unique);
//   // }

//   /// ---------------------------
//   /// General helpers
//   /// ---------------------------
//   Future<bool> remove(String key) async {
//     _checkInit();
//     return _prefs.remove(key);
//   }

//   Future<bool> clearAll() async {
//     _checkInit();
//     return _prefs.clear();
//   }

//   bool containsKey(String key) {
//     _checkInit();
//     return _prefs.containsKey(key);
//   }
// }
