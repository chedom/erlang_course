-module(week2_18).
-export([join/2, concat/1, member/2]).

join([], Ys) ->
    Ys;
join([X | Xs], Ys) ->
    [X | join(Xs, Ys)].

concat([]) ->
    [];
concat([Xs | Xss]) ->
    join(Xs, concat(Xss)).

member(_N, []) ->
    false;
member(N, [N | _Xs]) ->
    true;
member(N, [_X | Xs ]) ->
    member(N, Xs).
