#include <core.p4>
#include <dpdk/pna.p4>

bit<3> max(in bit<3> val, in bit<3> bound) {
    return val < bound ? val : bound;
}
header ethernet_t {
    bit<16> eth_type;
}
header priceX {
}
struct Headers {
    ethernet_t eth_hdr;
    priceX[4]  heal;
}
struct main_metadata_t {
}
bit<8> shouldr() {
    return 0;
}

parser MainParserImpl(packet_in pkt, out Headers hdr, inout main_metadata_t user_meta, in pna_main_parser_input_metadata_t istd) {
    state start {
    }
}

control PreControlImpl(in Headers hdr, inout main_metadata_t user_meta, in pna_pre_input_metadata_t istd, inout pna_pre_output_metadata_t ostd) {
    apply {
    }
}

control MainControlImpl(inout Headers hdr, inout main_metadata_t user_meta, in pna_main_input_metadata_t istd, inout pna_main_output_metadata_t ostd) {
    action revie(out priceX year, bit<128> orde, bit<128> priv) {
    }
    action compa() {
    }
    action resea(out bit<32> janu, bit<4> revi) {
    }
    table greatY {
        key = {
        }
        actions = {
            revie(hdr.heal[max((bit<3>)shouldr(), 3w3)]);
        }
    }
    apply {
        hdr.eth_hdr.eth_type = (greatY.apply().hit ? 16w48951 : 91w213560861023984182890738508[76:61] |-| 116w64291011913438215645283401046339830[19:4]);
    }
}

control MainDeparserImpl(packet_out pkt, in Headers hdr, in main_metadata_t user_meta, in pna_main_output_metadata_t ostd) {
    apply {
    }
}

PNA_NIC(MainParserImpl(), PreControlImpl(), MainControlImpl(), MainDeparserImpl()) main;