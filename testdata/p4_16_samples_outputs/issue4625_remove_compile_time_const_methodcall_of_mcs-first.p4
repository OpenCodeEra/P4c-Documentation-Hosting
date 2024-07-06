header h_t {
    bit<8> f;
}

control C() {
    action bar() {
        h_t h;
    }
    table t {
        actions = {
            bar();
        }
        default_action = bar();
    }
    apply {
        t.apply();
    }
}

control proto();
package top(proto p);
top(C()) main;
