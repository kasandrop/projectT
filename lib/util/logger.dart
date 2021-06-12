import 'dart:convert';

import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  static final levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.fg(12),
    Level.info: AnsiColor.fg(22),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  static final levelEmojis = {
    Level.verbose: '',
    Level.debug: '🐛 ',
    Level.info: '💡 ',
    Level.warning: '⚠️ ',
    Level.error: '⛔ ',
    Level.wtf: '👾 ',
  };

  static final stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  static final DateTime _startTime = DateTime.now();

  final int methodCount;
  final int errorMethodCount;
  final int lineLength;
  final bool colors;
  final bool printEmojis;
  final bool printTime;

  String _topBorder = '';

  SimpleLogPrinter({
    this.methodCount = 1,
    this.errorMethodCount = 8,
    this.lineLength = 120,
    this.colors = true,
    this.printEmojis = true,
    this.printTime = false,
  }) {
    // _startTime ??= DateTime.now();

    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    var stackTraceStr = '';
    if (event.stackTrace == null) {
      if (methodCount > 0) {
        stackTraceStr = formatStackTrace(StackTrace.current, methodCount);
      }
    } else if (errorMethodCount > 0) {
      stackTraceStr = formatStackTrace(event.stackTrace!, errorMethodCount);
    }

    var errorStr = '';
    if (event.error != null) {
      errorStr = event.error.toString();
    }
    var timeStr = '';
    if (printTime) {
      timeStr = getTime();
    }

    return _formatAndPrint(
      event.level,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

  String formatStackTrace(StackTrace stackTrace, int methodCount) {
    var lines = stackTrace.toString().split('\n');

    var formatted = <String>[];
    var count = 0;
    for (var line in lines) {
      var match = stackTraceRegex.matchAsPrefix(line);
      if (match != null) {
        if (match.group(2)!.startsWith('package:logger')) {
          continue;
        }
        if (match.group(2)!.contains('simple_log_printer')) {
          continue;
        }
        var newLine = '#$count   ${match.group(1)} (${match.group(2)})';
        formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
        if (++count == methodCount) {
          break;
        }
      } else {
        formatted.add(line);
      }
    }

    if (formatted.isEmpty) {
      return '';
    } else {
      return formatted.join('\n');
    }
  }

  String getTime() {
    String _threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    var timeSinceStart = now.difference(_startTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart)';
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  AnsiColor _getLevelColor(Level level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  AnsiColor _getErrorColor(Level level) {
    if (colors) {
      if (level == Level.wtf) {
        return levelColors[Level.wtf]!.toBg();
      } else {
        return levelColors[Level.error]!.toBg();
      }
    } else {
      return AnsiColor.none();
    }
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String time,
    String error,
    String stacktrace,
  ) {
    var buffer = <String>[];

    // buffer.add(color(_topBorder));

    for (var line in error.split('\n')) {
      buffer.add(line);
    }

    for (var line in stacktrace.split('\n')) {
      buffer.add('$line');
    }

    //var emoji = _getEmoji(level);
    for (var line in message.split('\n')) {
      buffer.add('$line');
    }
    //buffer.add(color(_bottomBorder));

    return buffer;
  }
}

var log = Logger(
  printer: PrettyPrinter(
      methodCount: 1,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: false,
      // Colorful log messages
      printEmojis: false,
      // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
      ),
);
