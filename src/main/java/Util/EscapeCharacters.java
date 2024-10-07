package Util;

public class EscapeCharacters {
    public static String escapeSpecialCharacters(String input) {
        return input
                .replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("`", "\\`");  // Add more as needed
    }
}
