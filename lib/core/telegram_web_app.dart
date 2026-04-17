import 'dart:js_util' as js_util;
import 'dart:html' as html;

class TelegramWebApp {
  // Получаем объект Telegram.WebApp из JS
  static dynamic get _webApp => js_util.getProperty(html.window, 'Telegram') != null 
      ? js_util.getProperty(js_util.getProperty(html.window, 'Telegram'), 'WebApp') 
      : null;

  static String get platform => _webApp != null ? js_util.getProperty(_webApp, 'platform') : 'unknown';

  // Метод для получения данных пользователя
  static Map<String, dynamic>? get userData {
    if (_webApp == null) return null;
    var initDataUnsafe = js_util.getProperty(_webApp, 'initDataUnsafe');
    if (initDataUnsafe == null) return null;
    
    var user = js_util.getProperty(initDataUnsafe, 'user');
    if (user == null) return null;

    return {
      'id': js_util.getProperty(user, 'id'),
      'first_name': js_util.getProperty(user, 'first_name'),
      'username': js_util.getProperty(user, 'username'),
    };
  }

  // Метод для закрытия приложения
  static void close() {
    if (_webApp != null) {
      js_util.callMethod(_webApp, 'close', []);
    }
  }

  // Сообщаем Телеграму, что приложение готово к отрисовке
  static void ready() {
    if (_webApp != null) {
      js_util.callMethod(_webApp, 'ready', []);
    }
  }
}