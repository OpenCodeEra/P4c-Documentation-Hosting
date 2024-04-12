#include <core.p4>
#define V1MODEL_VERSION 20180101
#include <v1model.p4>

header ethernet_t {
    bit<48> dst_addr;
    bit<48> src_addr;
    bit<16> eth_type;
}

struct simple_struct {
    bit<128> a;
}

struct Headers {
    ethernet_t eth_hdr;
}

struct Metadata {
}

parser p(packet_in pkt, out Headers hdr, inout Metadata meta, inout standard_metadata_t stdmeta) {
    state start {
        pkt.extract<ethernet_t>(hdr.eth_hdr);
        transition accept;
    }
}

control ingress(inout Headers hdr, inout Metadata meta, inout standard_metadata_t stdmeta) {
    @name("ingress.test") simple_struct test_0;
    @name("ingress.pointless_action") action pointless_action() {
        test_0 = test_0;
    }
    apply {
        test_0 = (simple_struct){a = 128w0};
        pointless_action();
        if (test_0.a != 128w1 && test_0.a <= 128w1) {
            hdr.eth_hdr.eth_type = 16w1;
        }
    }
}

control deparser(packet_out packet, in Headers hdr) {
    apply {
        packet.emit<Headers>(hdr);
    }
}

control egress(inout Headers hdr, inout Metadata meta, inout standard_metadata_t stdmeta) {
    apply {
    }
}

control vrfy(inout Headers hdr, inout Metadata meta) {
    apply {
    }
}

control update(inout Headers hdr, inout Metadata meta) {
    apply {
    }
}

V1Switch<Headers, Metadata>(p(), vrfy(), ingress(), egress(), update(), deparser()) main;