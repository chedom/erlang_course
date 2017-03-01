-module(week2_18).
-export([join/2, concat/1]).

join([], Ys) ->
    Ys;
join([X | Xs], Ys) ->
    [X | join(Xs, Ys)].

concat([]) ->
    [];
concat([Xs | Xss]) ->
    join(Xs, concat(Xss)).