void add_foo_tests () {
    Test.add_func (@"/$(Constants.APP_NAME)/hello", () => {
        assert ({{APP_NAMESPACE}}.say_hello ("World") == "Hello World!");
    });
}

void main (string[] args) {
    Test.init (ref args);
    add_foo_tests ();
    Test.run ();
}
