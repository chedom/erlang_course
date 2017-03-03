-module(assignment).
-export([test/0, processLine/1]).
-import(index, [get_file_contents/1]).

test() ->
    get_file_contents("index.erl").

processLine(Xs) ->
    filter(splitWords(map(fun nocap/1, Xs)), fun(X) -> length(X) > 2 end).

flatMap(_F, []) ->
    [];
flatMap(F, [X | Xs]) ->
    F(X) ++ flatMap(Xs, F).

map(_F, []) ->
    [];
map(F, [X | Xs]) ->
    [F(X) | map(F, Xs)].

member([], _X) ->
    false;
member([X | _Xs], X) ->
    true;
member([_Y | Xs], X) ->
    member(Xs, X).

splitWords(Str) ->
    splitWords(Str, [], []).
splitWords([], Accum, Temp) ->
    filter(Accum ++ [Temp], fun(X) -> X /= [] end);
splitWords([C | Cs], Accum, Temp) ->
    case member(".,\ ;:\t\n\'-", C) of
        true -> splitWords(Cs, Accum ++ [Temp], []);
        false -> splitWords(Cs, Accum, Temp ++ [C])
    end.

nocap(X) ->
    case $A=< X andalso X =< $Z of
        true -> X + 32;
        false -> X
    end.

filter([], _F) ->
    [];
filter([X | Xs], F) ->
    case F(X) of 
        true -> [X | filter(Xs, F)];
        false -> filter(Xs, F)
    end.
