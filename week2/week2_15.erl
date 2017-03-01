-module(week2_15).
-export([init/1, last/1, palindrome/1]).

init([]) ->
    [];
init([_X]) ->
    [];
init([X | Xs]) ->
    [X | init(Xs)].

last([]) ->
    badarg;
last([X]) ->
    X;
last([_X | Xs]) ->
    last(Xs).

palindrome([]) ->
    true;
palindrome([_X]) ->
    true;
palindrome([X | Xs]) ->
    case  X == last(Xs) of
        true -> palindrome(init(Xs));
        false -> false
    end.

