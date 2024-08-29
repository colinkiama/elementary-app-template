void add_foo_tests () {
    Test.add_func ("/my-app/hello", () => {
        assert (MyApp.say_hello ("World") == "Hello World!");
    });
}

void main (string[] args) {
    Test.init (ref args);
    add_foo_tests ();
    Test.run ();
}
