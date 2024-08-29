namespace MyApp {
    /**
     * Say hello to anything or anyone!
     *
     * @return string in the format of: Hello ``noun``
     */
    public static string say_hello (string? noun) {
        if (noun == null) {
            return "Hello";
        }

        return @"Hello $(noun)!";
    }
}
