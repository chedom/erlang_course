-module(week2_6).
-export([direct_maximum/1, tail_maximum/1, direct_product/1, tail_product/1]).

direct_maximum([X]) -> X;
direct_maximum([X | Xs]) -> max(X, direct_maximum(Xs)). 

tail_maximum([X | Xs]) -> tail_maximum_loop(Xs, X).
tail_maximum_loop([], MAX) -> MAX;
tail_maximum_loop([X | Xs], MAX) -> tail_maximum_loop(Xs, max(X, MAX)). 

direct_product([]) -> 1;
direct_product([X | Xs]) -> X * direct_product(Xs). 

tail_product(Xs) -> tail_product_loop(Xs, 1).
tail_product_loop([], ACCUM) -> ACCUM;
tail_product_loop([X | Xs], ACCUM) -> tail_product_loop(Xs, ACCUM * X).
