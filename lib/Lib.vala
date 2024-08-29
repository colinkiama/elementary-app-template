namespace MyApp {
    public static string say_hello (string? noun) {
        if (noun == null) {
            return "Hello";
        }

        return @"Hello $(noun)!";
    }
}
