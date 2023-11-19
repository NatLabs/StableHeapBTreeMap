import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Int "mo:base/Int";
import Blob "mo:base/Blob";
import Nat64 "mo:base/Nat64";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Prelude "mo:base/Prelude";
import RbTree "mo:base/RBTree";

import BTree "../src/BTree";
import Bench "mo:bench";
import Fuzz "mo:fuzz";

module {
    type BTree<K, V> = BTree.BTree<K, V>;

    public func init() : Bench.Bench {
        let fuzz = Fuzz.Fuzz();

        let bench = Bench.Bench();
        bench.name("RBTree vs BTree");
        bench.description("Benchmarking the performance with 10k entries");

        bench.rows(["RBTree", "BTree"]);
        bench.cols(["insert()", "get()",  "delete()"]);

        let limit = 10_000;

        let btree : BTree<Nat, Nat> = BTree.init(?32);
        let rbtree = RbTree.RBTree<Nat, Nat>(Nat.compare);

        let insert_values = Buffer.Buffer<Nat>(limit);

        for (i in Iter.range(0, limit - 1)){
            insert_values.add(fuzz.nat.randomRange(1, limit));
        };

        bench.runner(
            func(row, col) = switch (row, col) {

                case ("RBTree", "insert()") {
                    var i = 0;

                    for (val in insert_values.vals()){
                        rbtree.put(i, val);
                        i+=1;
                    }
                };
                case("RBTree", "get()") {
                    for (i in Iter.range(0, limit - 1)) {
                        ignore rbtree.get(i);
                    };
                };
                case("RBTree", "delete()") {
                    for (i in Iter.range(0, limit - 1)) {
                        rbtree.delete(i);
                    };
                };

                case ("BTree", "insert()") {
                    var i = 0;

                    for (val in insert_values.vals()){
                        ignore BTree.insert(btree, Nat.compare, i, val);
                        i+=1;
                    }
                };
                case("BTree", "get()") {
                    for (i in Iter.range(0, limit - 1)) {
                        ignore BTree.get(btree, Nat.compare, i);
                    };
                };
                case ("BTree", "delete()") {
                    for (i in Iter.range(0, limit - 1)) {
                        ignore BTree.delete(btree, Nat.compare, i);
                    };
                };
                case (_) {
                    Debug.trap("Should not reach with row = " # debug_show row # " and col = " # debug_show col);
                };
            }
        );

        bench;
    };
};
