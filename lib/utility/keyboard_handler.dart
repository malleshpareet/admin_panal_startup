import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Utility class to handle keyboard events and prevent assertion errors
class KeyboardHandler {
  static bool _isShiftPressed = false;
  static bool _isCtrlPressed = false;
  static bool _isAltPressed = false;

  /// Initialize keyboard listeners to track key states
  static void initialize() {
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  /// Remove keyboard listeners
  static void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
  }

  /// Handle key events to track modifier key states
  static bool _handleKeyEvent(KeyEvent event) {
    try {
      // Track modifier keys state
      if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
          event.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftPressed = event is KeyDownEvent || event is KeyRepeatEvent;
      }

      if (event.logicalKey == LogicalKeyboardKey.controlLeft ||
          event.logicalKey == LogicalKeyboardKey.controlRight) {
        _isCtrlPressed = event is KeyDownEvent || event is KeyRepeatEvent;
      }

      if (event.logicalKey == LogicalKeyboardKey.altLeft ||
          event.logicalKey == LogicalKeyboardKey.altRight) {
        _isAltPressed = event is KeyDownEvent || event is KeyRepeatEvent;
      }

      // Return false to allow the event to be handled normally
      return false;
    } catch (e) {
      // Catch any keyboard event handling errors
      debugPrint('Keyboard event handling error: $e');
      return false;
    }
  }

  /// Check if shift key is currently pressed
  static bool isShiftPressed() => _isShiftPressed;

  /// Check if control key is currently pressed
  static bool isCtrlPressed() => _isCtrlPressed;

  /// Check if alt key is currently pressed
  static bool isAltPressed() => _isAltPressed;

  /// Clear all key states (useful when app loses focus)
  static void clearKeyStates() {
    _isShiftPressed = false;
    _isCtrlPressed = false;
    _isAltPressed = false;
  }
}
