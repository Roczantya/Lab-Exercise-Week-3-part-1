import 'dart:math';

// ANSI Color codes for Windows CMD in Dart
const String RESET = '\x1B[0m'; // Reset all styles

// Basic Colors
const String BLACK = '\x1B[30m';
const String RED = '\x1B[31m';
const String GREEN = '\x1B[32m';
const String YELLOW = '\x1B[33m';
const String BLUE = '\x1B[34m';
const String MAGENTA = '\x1B[35m';
const String CYAN = '\x1B[36m';
const String WHITE = '\x1B[37m';

// Bright Colors
const String BRIGHT_BLACK = '\x1B[90m';
const String BRIGHT_RED = '\x1B[91m';
const String BRIGHT_GREEN = '\x1B[92m';
const String BRIGHT_YELLOW = '\x1B[93m';
const String BRIGHT_BLUE = '\x1B[94m';
const String BRIGHT_MAGENTA = '\x1B[95m';
const String BRIGHT_CYAN = '\x1B[96m';
const String BRIGHT_WHITE = '\x1B[97m';

// Background Colors
const String BG_BLACK = '\x1B[40m';
const String BG_RED = '\x1B[41m';
const String BG_GREEN = '\x1B[42m';
const String BG_YELLOW = '\x1B[43m';
const String BG_BLUE = '\x1B[44m';
const String BG_MAGENTA = '\x1B[45m';
const String BG_CYAN = '\x1B[46m';
const String BG_WHITE = '\x1B[47m';

// Bright Backgrounds
const String BG_BRIGHT_BLACK = '\x1B[100m';
const String BG_BRIGHT_RED = '\x1B[101m';
const String BG_BRIGHT_GREEN = '\x1B[102m';
const String BG_BRIGHT_YELLOW = '\x1B[103m';
const String BG_BRIGHT_BLUE = '\x1B[104m';
const String BG_BRIGHT_MAGENTA = '\x1B[105m';
const String BG_BRIGHT_CYAN = '\x1B[106m';
const String BG_BRIGHT_WHITE = '\x1B[107m';

String getRandomColor(String exception) {
  List<String> colors = [RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE];
  colors.remove(exception);
  String selectedColor = colors[Random().nextInt(colors.length)];
  return selectedColor;
}

String getBackgroundColor(String textColor) {
  switch (textColor) {
    case RED:
      return BG_BRIGHT_RED; // Background terang buat warna merah
    case GREEN:
      return BG_BRIGHT_GREEN; // Background terang buat warna hijau
    case YELLOW:
      return BG_BRIGHT_YELLOW; // Background terang buat warna kuning
    case BLUE:
      return BG_BRIGHT_BLUE; // Background terang buat warna biru
    case MAGENTA:
      return BG_BRIGHT_MAGENTA; // Background terang buat warna magenta
    case CYAN:
      return BG_BRIGHT_CYAN; // Background terang buat warna cyan
    case WHITE:
      return BG_BRIGHT_WHITE; // Background terang buat warna putih
    default:
      return RESET; // Kembali ke reset kalo warna gak dikenali
  }
}
